#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=20G
#SBATCH --time=03:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="3FastQC"



cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri

module load UHTS/Quality_control/fastqc/0.11.9

fastqc 3_2_L3_R1*
