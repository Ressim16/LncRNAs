#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=20G
#SBATCH --time=08:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="Mapping_Hisat2"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/LncRNAs/output_slurm_HISAT2-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/LncRNAs/error_slurm_HISAT2-%j.e

REF=/data/courses/rnaseq_course/lncRNAs/Project2/references
THREADS=

module load UHTS/Aligner/hisat/2.2.1

hisat2-build
