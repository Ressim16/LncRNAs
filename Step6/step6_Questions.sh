#!/usr/bin/env bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=5G
#SBATCH --time=00:20:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Step6_Q&A"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/output_slurm_Q&A-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/error_slurm_Q&A-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6

# WORKFLOW 1) Bedfiles, Bedtools Intergenic, 2) Window, Overlap, 3) CPAT

#Global variables
Transcripts_Total=$(cat All_Transcripts.bed | wc -l)
New_Transcripts_Total=$(cat New_Transcripts.bed | wc -l)

###Question : How many novel “intergenic” genes
New_Intergenic=$(cat Intergenic_novel.bed | wc -l)

###Question : What % of New transcripts are prot coding? 
#To know : limit value is 0.364 for CPAT tool, below it's considered non-coding
#REMINDER : we want non-coding gene for lncRNA !!!
New_Coding=$(awk '{if($5 > 0.364) print}' New_Potential_Coding.dat | wc -l)
Percentage_Coding_Transcript=$(echo "scale=5; $New_Coding/$New_Transcripts_Total * 100" | bc)

###Question : How good are the 5’ and 3’ annotations of your transcripts? assess what percentage of transcripts have a correct end annotation.
##For 5'
New_TSS=$(cat Overlap_start.bed | wc -l)
Percentage_TSS=$(echo "scale=5; $New_TSS/$New_Transcripts_Total * 100" | bc)
#For 3'
New_TES=$(cat Overlap_end.bed | wc -l)
Percentage_TES=$(echo "scale=5; $New_TES/$New_Transcripts_Total * 100" | bc)


touch Questions_Step6.txt
echo "----- Question 1 -----" > Questions_Step6.txt
echo "TSS (5' sites) percentage of transcripts : $Percentage_TSS %" >> Questions_Step6.txt
echo "TES (3' sites) percentage of transcripts : $Percentage_TES %" >> Questions_Step6.txt
echo >> Questions_Step6.txt
echo "----- Question 2 -----" >> Questions_Step6.txt
echo "Percentage of novel transcripts that are protein coding : $Percentage_Coding_Transcript %" >> Questions_Step6.txt
echo >> Questions_Step6.txt
echo "----- Question 3 -----" >> Questions_Step6.txt
echo "Number of novel 'intergenic' genes identified : $New_Intergenic" >> Questions_Step6.txt