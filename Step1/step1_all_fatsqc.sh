#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=20G
#SBATCH --time=04:00:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@unifr.ch
#SBATCH --mail-type=fail
#SBATCH --job-name="All_3FastQC"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step1/output_slurm_FASTQC-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step1/error_slurm_FASTQC-%j.e


###moving to the right directoy
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step1

###loading module
module load UHTS/Quality_control/fastqc/0.11.9

###Paraclonal cells
for file in /data/courses/rnaseq_course/lncRNAs/fastq/3*.fastq.gz
do 
    fastqc $file
done

###Parental cells
for file in /data/courses/rnaseq_course/lncRNAs/fastq/P*.fastq.gz
do 
    fastqc $file
done

### The Fastqc Sofwtare allows us to analyze the quality of our reads
###downloading the _fastqc.html to check for the data quality
# scp rzahri@login8.hpc.binf.unibe.ch:/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step1/*.html C:\Users\redaz\Documents\Uni\Master\RNA-seq\Steps\Step1\

###The volume and amount of data are showed with the help of bash/awk
touch Volume_of_data.txt
echo -e "###Volume of data [GB] per file :" > Volume_of_data.txt
for file in /data/courses/rnaseq_course/lncRNAs/fastq/[P3]*.fastq.gz
do
    ls -sh $file >> Volume_of_data.txt
done

###Number of reads per file
echo -e "\n###Number of reads per file:" >> Volume_of_data.txt
for file in /data/courses/rnaseq_course/lncRNAs/fastq/[P3]*.fastq.gz
do
    echo -e "\t Number of reads for the $file file : " >> Volume_of_data.txt
    zgrep -c @ $file >> Volume_of_data.txt
done