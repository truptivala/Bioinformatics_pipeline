##Pipeline to run all-proteins BLAST against Mycobacterium tuberculosis H37Rv

##Introduction:
This is a simple bioinformatics pipeline to run blast of microbial genome against Mycobacterium tuberculosis H37Rv pathogenic strain. It takes query protein sequences in fasta format as input file param and runs blast in "parallel" by requesting available resources depending on data.

##Prerequisites:
You're going to need:
- Perl 5 or later
- Getopt::Long;
- Parallel::ForkManager;
- File::Basename;
- Bio::SeqIO;
- BLAST plus executables
- Mycobacterium tuberculosis H37Rv.faa
- Input query reference proteins (for example, Mycobacterium_bovis.faa)

##Getting setup:
For given input file (for example, Mycobacterium_bovis.faa), you can run the script using below command on ubuntu:
sudo perl blastallseq.pl -input /path/to/input/Mycobacterium_bovis.faa

##How does it work:
This script takes query sequence and generates input files for each sequence. Perl Parallel ForkManager creates a child process and runs blastp for each input sequence in parallel. It waits for all child processes to complete and merges output from each output file. The final output file is "finaloutput.txt".

I have created 8 child processes using ForkManager. Based on the machine capabilities, it can be increased to process faster. The main idea is to do parallel processing to utilize available resources as much as possible.

Fundamental concept:
- Split huge file into small chunk
- Do parallel processing of each unit
- Merge the result

This algorithm is kind of adopting fundamental concept of Hadoop MapReduce.

##Example:
Run the following command:
sudo perl blastallseq.pl -input home/ubuntu/trupti/Mycobacterium_bovis.faa

##Output:
finaloutput.txt file generated once the script finishes execution.

| CDO42245.1 | NP_215490.1    | 100.00 | 349 | 0  | 0 | 1 | 349 | 1   | 349 | 0.0    | 714  |
|------------|----------------|--------|-----|----|---|---|-----|-----|-----|--------|------|
| CDO42246.1 | NP_215491.1    | 100.00 | 560 | 0  | 0 | 1 | 560 | 1   | 560 | 0.0    | 1126 |
| CDO42247.1 | YP_177773.1    | 100.00 | 923 | 0  | 0 | 1 | 923 | 1   | 923 | 0.0    | 1612 |
| CDO42248.1 | YP_177774.1    | 93.73  | 335 | 17 | 1 | 1 | 335 | 1   | 331 | 1e-130 | 377  |
| CDO42249.1 | NP_215494.2    | 100.00 | 64  | 0  | 0 | 1 | 64  | 1   | 64  | 5e-41  | 128  |
| CDO42250.1 | YP_177635.1    | 100.00 | 57  | 0  | 0 | 1 | 57  | 1   | 57  | 2e-35  | 113  |
| CDO42251.1 | YP_177775.1    | 99.56  | 457 | 2  | 0 | 1 | 457 | 1   | 457 | 0.0    | 833  |
| CDO42252.1 | NP_215496.2    | 99.56  | 228 | 1  | 0 | 1 | 228 | 1   | 228 | 4e-161 | 446  |
| CDO42253.1 | NP_215497.1    | 99.80  | 504 | 1  | 0 | 1 | 504 | 1   | 504 | 0.0    | 995  |
| CDO42254.1 | NP_215498.1    | 99.78  | 464 | 1  | 0 | 1 | 464 | 1   | 464 | 0.0    | 899  |
| CDO41335.1 | NP_214611.1    | 100.00 | 289 | 0  | 0 | 1 | 289 | 1   | 289 | 0.0    | 595  |
| CDO42255.1 | NP_215499.1    | 100.00 | 181 | 0  | 0 | 1 | 181 | 1   | 181 | 7e-124 | 348  |
| CDO42256.1 | NP_215500.1    | 100.00 | 151 | 0  | 0 | 1 | 151 | 1   | 151 | 1e-105 | 299  |
| CDO42257.1 | NP_215501.1    | 99.60  | 248 | 1  | 0 | 1 | 248 | 1   | 248 | 0.0    | 501  |
| CDO42258.1 | NP_215502.1    | 100.00 | 423 | 0  | 0 | 1 | 423 | 1   | 423 | 0.0    | 848  |
| CDO42259.1 | NP_215502.1    | 99.54  | 431 | 2  | 0 | 1 | 431 | 425 | 855 | 0.0    | 862  |
| CDO42260.1 | NP_215503.1    | 99.48  | 386 | 2  | 0 | 1 | 386 | 1   | 386 | 0.0    | 780  |
| CDO42261.1 | NP_215504.1    | 99.69  | 325 | 1  | 0 | 1 | 325 | 1   | 325 | 0.0    | 655  |
| CDO42262.1 | NP_215505.1    | 99.54  | 218 | 1  | 0 | 1 | 218 | 1   | 218 | 3e-146 | 408  |
| CDO42263.1 | NP_215506.1    | 100.00 | 110 | 0  | 0 | 1 | 110 | 1   | 110 | 2e-73  | 214  |
| CDO42264.1 | NP_215507.1    | 99.49  | 197 | 1  | 0 | 1 | 197 | 1   | 197 | 2e-135 | 378  |
| CDO41336.1 | NP_214612.1    | 100.00 | 183 | 0  | 0 | 1 | 183 | 1   | 183 | 2e-136 | 380  |
| CDO42265.1 | NP_215508.1    | 99.67  | 306 | 1  | 0 | 1 | 306 | 1   | 306 | 0.0    | 598  |
| CDO42266.1 | YP_177776.1    | 99.77  | 426 | 1  | 0 | 1 | 426 | 1   | 426 | 0.0    | 825  |
| CDO42267.1 | NP_215510.1    | 100.00 | 203 | 0  | 0 | 1 | 203 | 1   | 203 | 2e-145 | 404  |
| CDO42268.1 | NP_215511.1    | 99.44  | 358 | 2  | 0 | 1 | 358 | 1   | 358 | 0.0    | 705  |
| CDO42269.1 | YP_009030028.1 | 100.00 | 83  | 0  | 0 | 1 | 83  | 1   | 83  | 5e-58  | 173  |
