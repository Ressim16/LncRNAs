#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:20:00
#SBATCH --job-name=rzahri
#SBATCH --mail-user=reda.zahri@hotmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Intergenic_Potential_lncRNAs"
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step7/output_slurm_Potential-%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step7/error_slurm_Potential-%j.e

cd /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step7

#adding the results from > sleuth_selected_pot_lncRNAs$target_id in Step7_lncRNAs.R
lst=$(echo MSTRG.26634.1 MSTRG.15584.5 MSTRG.25879.6 MSTRG.7557.10 MSTRG.11987.15 MSTRG.11156.1 MSTRG.18834.15 MSTRG.17250.1 MSTRG.2553.9 MSTRG.8605.9 MSTRG.16325.6 MSTRG.19277.10 MSTRG.26192.2 MSTRG.23089.9 MSTRG.7089.14 MSTRG.12179.7 MSTRG.13042.1 MSTRG.396.1 MSTRG.458.1 MSTRG.26934.3 MSTRG.4223.3 MSTRG.6042.2 MSTRG.16482.5 MSTRG.26455.10 MSTRG.13307.8 MSTRG.18554.1 MSTRG.18071.8 MSTRG.1346.1 MSTRG.5220.5 MSTRG.48.2 MSTRG.5356.1 MSTRG.22075.30 MSTRG.21858.2 MSTRG.28646.2 MSTRG.5026.2 MSTRG.1213.11 MSTRG.934.4 MSTRG.6385.4 MSTRG.119.1 MSTRG.8535.6 MSTRG.13346.4) 
touch Pot_and_Intergenic.txt
for i in $lst
do     
    target_id=$(echo $i)     
    awk -v pattern="$target_id" -F "\t" '{if($6~pattern) print}' Intergenic_novel.bed >> Pot_and_Intergenic.txt
done

#checking if result file is empty
if [ ! -s Pot_and_Intergenic.txt ]
then
    echo "File is empty"
else
    echo "File is not empty, we got new potential intergenic ncRNAs"
fi
