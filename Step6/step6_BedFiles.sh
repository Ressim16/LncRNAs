#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=3:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Start_End"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/output_slurm_BedFiles-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/error_slurm_BedFIles-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6

#Variables
ASSEMBLY_PATH=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3

#copy and paste GTF merged in step6 directory to work with afterwards
cp $ASSEMBLY_PATH/ALL_cells_merged.gtf .

#Parsing and having bedfiles
awk -F $'\t' '$3=="transcript"' $ASSEMBLY_PATH/ALL_cells_merged.gtf | awk '$1 ~ /chr/ {print $1, $4, $5, $6, $7, $12}' | sed 's/;//g' | sed 's/"//g' | sed 's/ /\t/g' > All_Transcripts.bed
awk -F $'\t' '$3=="transcript"' $ASSEMBLY_PATH/ALL_cells_merged.gtf | grep -v 'ENS' | awk '$1 ~ /chr/ {print $1, $4, $5, $6, $7, $12}' | sed 's/;//g' | sed 's/"//g' | sed 's/ /\t/g' > New_Transcripts.bed
awk -F $'\t' '$3=="transcript"' $ASSEMBLY_PATH/ALL_cells_merged.gtf | grep 'ENS' | awk '$1 ~ /chr/ {print $1, $4, $5, $6, $7, $12}' | sed 's/;//g' | sed 's/"//g' | sed 's/ /\t/g' > Annot_Transcripts.bed
#in this order like this. chromosome,start,end,name,score and strand
awk -F '\t' '$5=="+"' New_Transcripts.bed | awk '{print $1"\t"$2"\t"$3"\t"$6"\t"$4"\t"$5}' > +_Strand.bed
awk -F '\t' '$5=="-"' New_Transcripts.bed | awk '{print $1"\t"$2"\t"$3"\t"$6"\t"$4"\t"$5}' > -_Strand.bed


###Intersect with the BEDTools module
module load UHTS/Analysis/BEDTools/2.29.2

###collect intergenic regions 
#using the inverse of the intersect tool with -v to keep only the intergenic regions
#-a and -b are for comparing a to b files
#.bed file need to have $1 == "chr" and "\t" sep --> checking on previous steps
bedtools intersect -v -a ./New_Transcripts.bed -b ./Annot_Transcripts.bed > Intergenic_novel.bed

