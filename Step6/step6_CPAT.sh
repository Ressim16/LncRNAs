#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="CPAT"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/output_slurm_CPAT-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/error_slurm_CPAT-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6

#variables
DIR_REF=/data/courses/rnaseq_course/lncRNAs/Project2/references

module load SequenceAnalysis/GenePrediction/cpat/1.2.4
module load UHTS/Analysis/BEDTools/2.29.2

#running the commands
#cpat is used with a fasta file got with bedtools right below, and then we generate an output 
# put all the potential non-coding/coding transcript that reached under a ceratin probability --> we will need to parse it later to exclude coding or non-coding potential transcripts
bedtools getfasta -s -name -fi $DIR_REF/GRCh38.genome.fa -bed ./New_Transcripts.bed -fo REF_New_Transcripts.fa
cpat.py --gene REF_New_Transcripts.fa --logitModel $DIR_REF/Human_logitModel.RData --hex $DIR_REF/Human_Hexamer.tsv -o New_Potential_Coding


