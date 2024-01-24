#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1:00:00
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Overlap"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/output_slurm_Overlap-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6/error_slurm_Overlap-%j.e

###I had some issues with this slurm, I had some outfiles but they were empty
##Dario helped me to figure it out, bedtools intersect need also the "score" column of the .bed files
#Then I modified the previous slurm (step6_BedFiles and step6_Window) to integrate the score column
#that's why I putted the "echo" lines to check where was the problem (with even didn't help, bedtools was still processing without any error...)

echo "Script started..."
module load UHTS/Analysis/BEDTools/2.29.2

#variables
DIR_REF=/data/courses/rnaseq_course/lncRNAs/Project2/references
ACT_DIR=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6

###bed file with only novel transcripts + implement window of +- 50nt
##and only for starting or TSS and ending TES (later in the script, same commands but with the other nt site)
##We are targetting with the input New_Transcripts --> not only the intergenic regions !
#TSS + AND -
awk '{if ($5 == "+") print $1"\t"$2-50"\t"$2+50"\t"$6"\t"$4"\t"$5; else print $1"\t"$3-50"\t"$3+50"\t"$6"\t"$4"\t"$5}' New_Transcripts.bed > TSS_novel.bed
#TES + AND -
awk '{if ($5 == "+") print $1"\t"$3-50"\t"$3+50"\t"$6"\t"$4"\t"$5; else print $1"\t"$2-50"\t"$2+50"\t"$6"\t"$4"\t"$5}' New_Transcripts.bed > TES_novel.bed

#TSS -
#awk '$4 == "-" {print $1"\t"$3-50"\t"$3+50"\t"$4}' New_Transcripts.bed > TSS_-_novel.bed
#TES -
#awk '$4 == "-" {print $1"\t"$2-50"\t"$2+50"\t"$4}' New_Transcripts.bed > TES_-_novel.bed

#also checked if any negative value with and there is any : any found
    ### $awk '$3<0' TSS_novel.bed
    ### $awk '$2<0' TSS_novel.bed
    ### $awk '$3<0' TES_novel.bed
    ### $awk '$2<0' TES_novel.bed


###Overlapping part with CAGE cluster and PolyA sites
#Making Overlap for TSS sites using CAGE Cluster
echo "Making Overlap for TSS sites..."
bedtools intersect -wa -s -a ./TSS_novel.bed -b $DIR_REF/refTSS_v4.1_human_coordinate.hg38.bed > Overlap_start.bed

#Making Overlap for TES (or PolyA) sites
echo "Making Overlap for TES (or PolyA) sites..."
bedtools intersect -wa -s -a ./TES_novel.bed -b $DIR_REF/atlas.clusters.2.0.GRCh38.96.bed > Overlap_end.bed

echo "Script done"