#!/usr/bin/env bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Kallisto"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4/output_slurm_Exos-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4/error_slurm_Exos-%j.e

DIR=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4
SAMPLES="$DIR/3_2 $DIR/3_4 $DIR/3_7 $DIR/P1 $DIR/P2 $DIR/P3"

cd $DIR
touch exercices_step4.txt
echo "Quantification quality analysis :" > exercices_step4.txt

###1) What units of expressions are you using ?
echo "### 1) We are using counts expression and also tmp units to quantify each biological replicate." >> exercices_step4.txt

###2) Quality check: Does the entire expression level across all genes add up to the expected amount?
#the goal is to sum for every line, the tmp counts and we should have 1'000'000
#awk -F '\t' '{sum+=$5}; END {print sum}' abundance.tsv 
echo -e "\n### 2) TPM Values :" >> exercices_step4.txt
for sample in $SAMPLES
do
    total_tpm=$(awk -F '\t' '{sum+=$5}; END {print sum}' $sample/abundance.tsv)
    echo "The TPM sum of the $sample file is : $total_tpm" >> exercices_step4.txt
done

###3) How many transcripts and genes did you detect?
echo -e "\n### 3) Transcripts detected :" >> exercices_step4.txt
for sample in $SAMPLES
do
    total_transcripts=$(awk -F'\t' 'BEGIN{sum=-1} {if($4 > 0) sum+=1} END{print sum}' $sample/abundance.tsv)
    echo "The number of Transcripts of the $sample file is : $total_transcripts" >> exercices_step4.txt
done

echo -e "\n### 3) Genes detected :" >> exercices_step4.txt
for sample in $SAMPLES
do
    total_genes=$(awk -F'\t' 'BEGIN{sum=0} $1 ~"\.1$" {if ($4>0) sum+=1} END{print sum}' $sample/abundance.tsv)
    echo "The number of Genes of the $sample file is : $total_genes" >> exercices_step4.txt
    #here on the awk pattern, we put à "$" to describe that each transcript should
    #be part of the only one gene .1 and $ is that the last character should be a .1 and no more
done



###4) How many novel transcripts and genes did you detect?
echo -e "\n### 4) Novel Transcripts detected :" >> exercices_step4.txt
for sample in $SAMPLES
do
    total_new_transcripts=$(awk -F'\t' 'BEGIN{sum=0} $1 ~ "MSTRG"  {if ($4>0) sum+=1} END{print sum}' $sample/abundance.tsv)
    echo "The number of Novel Transcripts of the $sample file is : $total_new_transcripts" >> exercices_step4.txt
done

echo -e "\n### 4) Novel Genes detected :" >> exercices_step4.txt
for sample in $SAMPLES
do
    total_new_genes=$(awk -F'\t' 'BEGIN{sum=0} $1 ~ "MSTRG" && $1 ~ "\.1$" {if ($4>0) sum+=1} END{print sum}' $sample/abundance.tsv)
    echo "The number of Novel Transcripts of the $sample file is : $total_new_genes" >> exercices_step4.txt
done

    