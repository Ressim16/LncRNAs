#!/usr/bin/env bash

#SBATCH --cpus-per-task=14
#SBATCH --mem-per-cpu=14G
#SBATCH --time=12:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="StringTie_Assembly"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/output_slurm_StringTie_Assembly-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/error_slurm_StringTie_Assembly-%j.e

#define variable
REF=/data/courses/rnaseq_course/lncRNAs/Project2/references
FASTQ=/data/courses/rnaseq_course/lncRNAs/fastq
BAM=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2
GUIDE=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

#if we aren't in the right wd
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

#loading the module
module load UHTS/Aligner/stringtie/1.3.3b
module load UHTS/Analysis/samtools/1.10

#variables
CELLS="3_2 3_4 3_7 P1 P2 P3"
GEN_ANN=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/gencode.v44.primary_assembly.annotation.gtf


###code
#first sorting bam file (already sorted in the step2_SAM_to_BAM job)
#samtools sort -o BAM_3_2.sorted.bam $BAM/*3_2.bam
#samtools sort -o BAM_3_4.sorted.bam $BAM/*3_4.bam
#samtools sort -o BAM_3_7.sorted.bam $BAM/*3_7.bam

#samtools sort -o BAM_P1.sorted.bam $BAM/*P1.bam
#samtools sort -o BAM_P2.sorted.bam $BAM/*P2.bam
#samtools sort -o BAM_P3.sorted.bam $BAM/*P3.bam


#creating assembly with StringTie
stringtie -p 2 -G $GEN_ANN -o Transcripts_3_2.gtf $BAM/*3_2.bam
stringtie -p 2 -G $GEN_ANN -o Transcripts_3_4.gtf $BAM/*3_4.bam
stringtie -p 2 -G $GEN_ANN -o Transcripts_3_7.gtf $BAM/*3_7.bam

stringtie -p 2 -G $GEN_ANN -o Transcripts_P1.gtf $BAM/*P1.bam
stringtie -p 2 -G $GEN_ANN -o Transcripts_P2.gtf $BAM/*P2.bam
stringtie -p 2 -G $GEN_ANN -o Transcripts_P3.gtf $BAM/*P3.bam
