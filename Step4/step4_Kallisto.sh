#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=3:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Kallisto"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4/output_slurm_Kallisto-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4/error_slurm_Kallisto-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4

#variables
GEN_ANN_PATH=/data/courses/rnaseq_course/lncRNAs/Project2/references
ASSEMBLY_PATH=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3
FASTQ_PATH=/data/courses/rnaseq_course/lncRNAs/fastq/


#loading modules kallisto and gffread (for the transciptome ref in fasta format)
#here we use the kallisto quantification to focus afterwards with sleuth (more efficient with Sleuth)
module add UHTS/Analysis/kallisto/0.46.0
module add UHTS/Assembler/cufflinks/2.2.1

#first creating a fasta transcripts file (our transcriptome reference made by the reference and the meta-data.GTF file)
gffread -w ./all_transcripts.fasta -g $GEN_ANN_PATH/GRCh38.genome.fa $ASSEMBLY_PATH/ALL_cells_merged.gtf

#then indexing with kallisto
kallisto index -i all_transcripts.index all_transcripts.fasta

#running kallisto for each strain 
###/!\ We must put the both FastQ files in the correct strandness, pair-end reads needs both files to realise the quantification by Kallisto
#bootstrapping with 20 (not too large, this step requires a lot of time)
kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./3_2 --rf-stranded $FASTQ_PATH/3_2_L3_R1*.fastq.gz $FASTQ_PATH/3_2_L3_R2*.fastq.gz
kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./3_4 --rf-stranded $FASTQ_PATH/3_4_L3_R1*.fastq.gz $FASTQ_PATH/3_4_L3_R2*.fastq.gz
kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./3_7 --rf-stranded $FASTQ_PATH/3_7_L3_R1*.fastq.gz $FASTQ_PATH/3_7_L3_R2*.fastq.gz

kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./P1 --rf-stranded  $FASTQ_PATH/P1_L3_R1*.fastq.gz $FASTQ_PATH/P1_L3_R2*.fastq.gz
kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./P2 --rf-stranded  $FASTQ_PATH/P2_L3_R1*.fastq.gz $FASTQ_PATH/P2_L3_R2*.fastq.gz
kallisto quant -b 20 -t 1 -i all_transcripts.index -o ./P3 --rf-stranded  $FASTQ_PATH/P3_L3_R1*.fastq.gz $FASTQ_PATH/P3_L3_R2*.fastq.gz

