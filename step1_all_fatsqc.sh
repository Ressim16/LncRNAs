#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=20G
#SBATCH --time=04:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="All_3FastQC"


cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/LncRNAs

module load UHTS/Quality_control/fastqc/0.11.9

for file in /data/courses/rnaseq_course/lncRNAs/fastq/3*.fastq.gz
do 
    fastqc $file
done

for file in /data/courses/rnaseq_course/lncRNAs/fastq/*fastqc*
do 
    mv $file /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/LncRNAs
done
