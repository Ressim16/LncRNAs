#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=12G
#SBATCH --time=02:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="Creating BAM Files"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2/output_slurm_BAM_Index-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2/error_slurm_BAM_Index-%j.e

#define variable
REF=/data/courses/rnaseq_course/lncRNAs/Project2/references
FASTQ=/data/courses/rnaseq_course/lncRNAs/fastq
SAM=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2

#if we aren't in the right wd
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2

#loading the module
module load UHTS/Analysis/samtools/1.10

#creating soft link ($ ln) (with -s arg) if doesn't exist already (-f arg)
###not necessary and I had issues with manipulating soft link

#variables
SAMPLES="SAM_3_2 SAM_3_4 SAM_3_7 SAM_P1 SAM_P2 SAM_P3"

###code for the index first
#deleting bam files already existing (first try with errors)
rm -rf SAM*.bam.bai*

for sam_files in $SAMPLES
do
    samtools index ${sam_files}.bam ${sam_files}.bam.bai
done

###code
#deleting bam files already existing  and ex slurm_job
rm -rf SAM*.bam*

###converting SAM to BAM files AND sorting at the same time (important for next step with StringTie)
#the command -sort allows us to convert SAM to BAM (instead of -view) and sort at the same time
for sam_files in $SAMPLES
do
    samtools sort -@ 8 -o ${sam_files}.bam ${sam_files}.sam
done