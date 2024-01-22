#!/usr/bin/env bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:05:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/output_slurm_StringTie_Exos-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3/error_slurm_StringTie_Exos-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

###code
touch exercices.txt
##number of exon/transcripts/genes
#transcripts
n_transcripts=$(awk '{if($3=="transcript") print}' ALL_cells_merged.gtf | wc -l)
echo "Number of transcripts : $n_transcripts" > exercices.txt

#exons
n_exons=$(awk '{if($3=="exon") print}' ALL_cells_merged.gtf | wc -l)
echo "Number of exons : $n_exons" >> exercices.txt

#genes
n_genes=$(awk '{if($3=="transcript") print($10)}' ALL_cells_merged.gtf | sort  | uniq | wc -l)
echo "Number of genes : $n_genes" >> exercices.txt



##number of novel exon/transcript/genes
#transcripts total - transcripts with reference
n_novel_transcripts=$(awk '$3 =="transcript" {if($12!~"ENS") print}' ALL_cells_merged.gtf | uniq -c | wc -l)
echo "Number of novel transcript : $n_novel_transcripts" >> exercices.txt

#exons
n_novel_exon=$(awk '$3 =="exon" {if($12!~"ENS") print}' ALL_cells_merged.gtf | uniq -c | wc -l)
echo "Number of novel exon (single exon) : $n_novel_exon" >> exercices.txt


###single exon transcripts/genes
n_single_exon_gene=$(awk '{if($3=="exon") print($10)}' ALL_cells_merged.gtf | uniq -c | awk '$1=="1"' | wc -l)
echo "Number of single exon gene : $n_single_exon_gene" >> exercices.txt

n_single_exon_transcript=$(awk '{if($3=="exon") print($12)}' ALL_cells_merged.gtf | uniq -c | awk '$1=="1"' | wc -l)
echo "Number of single exon transcript : $n_single_exon_transcript" >> exercices.txt