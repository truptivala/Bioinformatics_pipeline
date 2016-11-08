#!/usr/bin/perl

#This example script runs 8 copies of a subroutine simultaneously
# need to set path to input files on the command line
# Usage: blastallseq.pl -input path/to/input/files

use strict;
use warnings;
use Getopt::Long;
use Parallel::ForkManager;
use File::Basename;
use Bio::SeqIO;

####################################################
# Setting up command line options and usage errors #
####################################################

# set a command line option variable (-input); is required and is the path to the input files
my $input;

GetOptions( "input=s" => \$input ) || die "Can't find input file";

# fileparse() parses input file name and splits into filename, directory and extension
# $ifile: filename
# idir: directory path of the file
# iext: enxtension of file
my($ifile, $idir, $iext) = fileparse($input, qr/\.[^.]*/);

my $count = 1;
my $seqin  = Bio::SeqIO->new(-file => $input,      -format => "fasta");

# Iterate through each sequence and write into the separate file 
while(my $seq = $seqin->next_seq) {
    my $eachseq = $count."input.files";
#   print "$eachfile \n";
    my $seqout = Bio::SeqIO->new(-file => ">$idir/$eachseq", -format => "fasta");
    $seqout->write_seq($seq);
    $count++;
}
####################
# Parallel forking #
####################

my $fork_manager = Parallel::ForkManager->new(8);

# callback run when each process is started
$fork_manager->run_on_start( 
      sub {
         my ($pid,$ident) = @_;
         print "Starting processes under process id $pid\n";
      }
    );
	
# callback run when each process is finished

$fork_manager->run_on_finish( 
      sub {
         my ( $pid, $exit_code, $ident, $signal, $core ) = @_;
         if ( $core ) {
            print "Process (pid: $pid) core dumped.\n";
         } else {
            print "Process (pid: $pid) exited with code $exit_code and signal $signal.\n";
         }
      }
   );
   
# make array of input.files
my @array_of_input_files = glob("$idir/*input.files");

# loop through array of input files
for ( my $i = 0 ; $i < @array_of_input_files ; $i++ ) {

    # initiate a fork manager with 8 forks
    $fork_manager->start and next;

    # pass input.files to a subroutine
	blastall( $array_of_input_files[$i] );

    $fork_manager->finish;
}

# wait for all children
$fork_manager->wait_all_children;
  
if(system("> $idir/finaloutput.txt"))
{
	die "Can't create final output";
}

# Concat output to single file
if(system("cat $idir/*input_out.files >> $idir/finaloutput.txt")){
	die "Can't merge output";
}

#######################
# add subroutine here #
#######################

sub blastall {
	# input each sequence file
    my $fprocess = $_[0];
	
	# print "File name is: $fprocess \n" ;

    my($file, $dir, $ext) = fileparse($fprocess, qr/\.[^.]*/);
	#    print "Directory: ".$dir."\n";
	#    print "File:      ".$file."\n";
	#    print "Suffix:    ".$ext."\n";
    
	# generates output file for each blast run
    my $out = $dir.$file."_out".$ext;

	# print "blastp -query $fprocess -db Mycobacterium_tuberculosis_H37Rv.faa -evalue 0.0001 -out $out -outfmt 6 -max_target_seqs 1 \n";

    if(system( "blastp -query $fprocess -db Mycobacterium_tuberculosis_H37Rv.faa -evalue 0.0001 -out $out -outfmt 6 -max_target_seqs 1 \n")) {
		die "Can't run blast for file  $fprocess";
	}
}
