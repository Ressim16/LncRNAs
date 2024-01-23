#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=3:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="StringTie_Merging"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/output_slurm_StringTie_Merging-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/error_slurm_StringTie_Merging-%j.e

#define variable
REF=/data/courses/rnaseq_course/lncRNAs/Project2/references
FASTQ=/data/courses/rnaseq_course/lncRNAs/fastq
BAM=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2
GUIDE=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

#if we aren't in the right wd
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

#loading the module
module load UHTS/Aligner/stringtie/1.3.3b

#variables
GEN_ANN=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/gencode.v44.primary_assembly.annotation.gtf


###code
#creating list in a .txt file for Paraclonal and Parental
rm Transcripts_3_GTF.txt
rm Transcripts_P_GTF.txt

#creating text files whith every path for the merge stringtie tool
ls /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/Transcripts_3*.gtf > Transcripts_3_GTF.txt
ls /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/Transcripts_P*.gtf > Transcripts_P_GTF.txt
ls /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/Transcripts_*.gtf > Transcripts_ALL_GTF.txt

#Merging Paraclonal cells
stringtie --merge -p 3 -G $GEN_ANN -o Paraclonal_3_cells_merged.gtf Transcripts_3_GTF.txt
stringtie --merge -p 3 -G $GEN_ANN -o Parental_P_cells_merged.gtf Transcripts_P_GTF.txt
stringtie --merge -p 4 -G $GEN_ANN -o ALL_cells_merged.gtf Transcripts_ALL_GTF.txt


#Create a table with transcript_ID and gene_name (sep = " ") (our target mapping)
# $'\t' is for the separator type, 
#so here we choose only the transcripts that have been already annotated (with the gene_name) 
#and we select their transcripts ID (1st column of target mapping output) and their gene_name (2nd column of the target mapping output)
awk -F $'\t' '$3=="transcript"' ALL_cells_merged.gtf | grep 'gene_name' | awk -F $'\t' '{print $9}' | awk -F ';' '{print $2, $3}' | awk '{print $2, $4}' | sed 's/"//g' > TranscriptID_GeneName.txt
#selecting gene_type from gencode.v44.primary_assembly.annotation.gtf
awk -F $'\t' '{print $9}' gencode.v44.primary_assembly.annotation.gtf | awk -F ';' '$2 ~ "transcript_id" {print $2 $3}' | awk '{print $2 $4}' | sed 's/"/ /g' > TranscriptID_GeneType.txt
#joining the gene_type to the target mapping : sort first and join them in bash
sort TranscriptID_GeneName.txt > TranscriptID_GeneName.sorted
sort TranscriptID_GeneType.txt > TranscriptID_GeneType.sorted
join TranscriptID_GeneName.sorted TranscriptID_GeneType.sorted > target_mapping.txt