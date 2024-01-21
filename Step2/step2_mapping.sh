#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=20G
#SBATCH --time=06:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="Mapping_Hisat2"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2/output_slurm_HISAT2-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2/error_slurm_HISAT2-%j.e

#define variable
REF=/data/courses/rnaseq_course/lncRNAs/Project2/references

#if we aren't in the right wd
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/LncRNAs

#loading the module
module load UHTS/Aligner/hisat/2.2.1

#run HISAT2
hisat2-build -p 10 $REF/GRCh38.genome.fa human_genome


###second part for mapping cells
#-x for first specify the index, -1 for the 1st read in one sens, -2 for the 2nd on the other sens, -S for getting a SAM format file
#human_genome is the result file of the indexing on the first thing to do in step2 (file step2_mapping_ref_human.sh)
#R1 = forward and R2 are reverse for our data
##3_2 Fastq
hisat2 -p6 -x human_genome -1 $FASTQ/3_2_L3_R1_001_DID218YBevN6.fastq.gz -2 $FASTQ/3_2_L3_R2_001_UPhWv8AgN1X1.fastq.gz -S SAM_3_2.sam
##3_4 Fastq
hisat2 -p6 -x human_genome -1 $FASTQ/3_4_L3_R1_001_QDBZnz0vm8Gd.fastq.gz -2 $FASTQ/3_4_L3_R2_001_ng3ASMYgDCPQ.fastq.gz -S SAM_3_4.sam
##3_7 Fastq
hisat2 -p6 -x human_genome -1 $FASTQ/3_7_L3_R1_001_Tjox96UQtyIc.fastq.gz -2 $FASTQ/3_7_L3_R2_001_f60CeSASEcgH.fastq.gz -S SAM_3_7.sam

##Same but for Paraclonal
#P1
hisat2 -p6 -x human_genome -1 $FASTQ/P1_L3_R1_001_9L0tZ86sF4p8.fastq -2 $FASTQ/P1_L3_R2_001_yd9NfV9WdvvL.fastq -S SAM_P1.sam
#P2
hisat2 -p6 -x human_genome -1 $FASTQ/P2_L3_R1_001_R82RphLQ2938.fastq -2 $FASTQ/P2_L3_R2_001_06FRMIIGwpH6.fastq -S SAM_P2.sam
#P3
hisat2 -p6 -x human_genome -1 $FASTQ/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz -2 $FASTQ/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz -S SAM_P3.sam

###result would appear on the error_slurm or output_slurm of the submitted job --> very important to keep it and not remove it !!!


