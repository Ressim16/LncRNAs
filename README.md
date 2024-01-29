# LncRNAs RNA-seq Project at the Univeristy of Bern
## Master in Bioinformatics, Reda Zahri
### Course RNA-sequencing, January 2024

Group 1 : Analysis of Paraclonala and Parental cell types.

All the files and outputs obtained while using modules from vital-it and/or analyzing in Bash are located in the IBU cluster under : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri

Files used with R locally are all pushed into this GitHub project (step 5 and 7)

### Content of the different folders in the IBU cluster : (relevant for the processes during the report)
Indeed, many output files were made from error while progressing and ameliorating in the steps analysis

#### 1) Read quality : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step1
  - 3_2_L3_R1_001_DID218YBevN6_fastqc.html
  - 3_2_L3_R1_001_DID218YBevN6_fastqc.zip
  - 3_2_L3_R2_001_UPhWv8AgN1X1_fastqc.html
  - 3_2_L3_R2_001_UPhWv8AgN1X1_fastqc.zip
  - 3_4_L3_R1_001_QDBZnz0vm8Gd_fastqc.html
  - 3_4_L3_R1_001_QDBZnz0vm8Gd_fastqc.zip
  - 3_4_L3_R2_001_ng3ASMYgDCPQ_fastqc.html
  - 3_4_L3_R2_001_ng3ASMYgDCPQ_fastqc.zip
  - 3_7_L3_R1_001_Tjox96UQtyIc_fastqc.html
  - 3_7_L3_R1_001_Tjox96UQtyIc_fastqc.zip
  - 3_7_L3_R2_001_f60CeSASEcgH_fastqc.html
  - 3_7_L3_R2_001_f60CeSASEcgH_fastqc.zip

  - P1_L3_R1_001_9L0tZ86sF4p8_fastqc.html
  - P1_L3_R1_001_9L0tZ86sF4p8_fastqc.zip
  - P1_L3_R2_001_yd9NfV9WdvvL_fastqc.html
  - P1_L3_R2_001_yd9NfV9WdvvL_fastqc.zip
  - P2_L3_R1_001_R82RphLQ2938_fastqc.html
  - P2_L3_R1_001_R82RphLQ2938_fastqc.zip
  - P2_L3_R2_001_06FRMIIGwpH6_fastqc.html
  - P2_L3_R2_001_06FRMIIGwpH6_fastqc.zip
  - P3_L3_R1_001_fjv6hlbFgCST_fastqc.html
  - P3_L3_R1_001_fjv6hlbFgCST_fastqc.zip
  - P3_L3_R2_001_xo7RBLLYYqeu_fastqc.html
  - P3_L3_R2_001_xo7RBLLYYqeu_fastqc.zip

  - step1_all_fatsqc.sh
  - Volume_of_data.txt
  - error_slurm_FASTQC-11926190.e
  - output_slurm_FASTQC-11926190.o

#### 2) Read mapping : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step2
  - SAM_3_2.bam
  - SAM_3_2.sam
  - SAM_3_4.bam
  - SAM_3_4.sam
  - SAM_3_7.bam
  - SAM_3_7.sam
  - SAM_P1.bam
  - SAM_P1.sam
  - SAM_P2.bam
  - SAM_P2.sam
  - SAM_P3.bam
  - SAM_P3.sam

  - BAM_3_2.sorted.bam
  - BAM_3_4.sorted.bam
  - BAM_3_7.sorted.bam
  - BAM_P1.sorted.bam
  - BAM_P2.sorted.bam
  - BAM_P3.sorted.bam

  - error_slurm_BAM_Index-12023249.e
  - error_slurm_HISAT2-11921377.e
  - output_slurm_BAM_Index-12023249.o
  - output_slurm_HISAT2-11921377.o
  - step2_mapping.sh
  - step2_SAM_to_BAM.sh

#### 3) Transcriptome assembly : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step3
  - Transcripts_3_2.gtf
  - Transcripts_3_4.gtf
  - Transcripts_3_7.gtf
  - Transcripts_P1.gtf
  - Transcripts_P2.gtf
  - Transcripts_P3.gtf
  - ALL_cells_merged.gtf

  - exercices.txt
  - gencode.v44.primary_assembly.annotation.gtf
  - target_mapping_only.txt
  - step3_exercices.sh
  - step3_stringtie_assembly.sh
  - step3_stringtie_merge.sh

#### 4) Quantification : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step4
Each replicates has its own folder with the following files : abundance.h5, abundance.tsv, run_info.json
  - all_transcripts.fasta
  - all_transcripts.index
  - error_slurm_Exos-12444859.e
  - error_slurm_Kallisto-11953704.e
  - exercices_step4.txt
  - output_slurm_Exos-12444859.o
  - output_slurm_Kallisto-11953704.o
  - step4_exercices.sh
  - step4_Kallisto.sh

#### 5) Differential expression : -
The step 5 has been made locally in R studio, the files are located in the Step5 folder in this GitHub project

#### 6) Integrative analysis  : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step6
Bedfiles and Intergenic part :  
  - Intergenic_novel.bed
  - error_slurm_BedFIles-12008209.e
  - output_slurm_BedFiles-12008209.o
  - All_Transcripts.bed
  - Annot_Transcripts.bed
  - New_Transcripts.bed
  - step6_BedFiles.sh
  - error_slurm_BedFIles-12008209.e
  - output_slurm_BedFiles-12008209.o
Window and Overlapping part :
  - TES_novel.bed
  - TSS_novel.bed
  - Overlap_end.bed
  - Overlap_start.bed
  - step6_Overlap.sh
  - error_slurm_Overlap-11992776.e
  - output_slurm_Overlap-11992776.o
CPAT part :
  - REF_New_Transcripts.fa
  - New_Potential_Coding.dat
  - New_Potential_Coding.r
  - New_Transcripts.bed
  - step6_CPAT.sh
  - error_slurm_CPAT-11994619.e
  - output_slurm_CPAT-11994619.o
Answers for report :
  - step6_Questions.sh
  - Questions_Step6.txt

#### 7) Prioritization : /data/courses/rnaseq_course/lncRNAs/Project2/users/rzahri/step7
  - error_slurm_Potential-12467422.e
  - Intergenic_novel.bed
  - output_slurm_Potential-12467422.o
  - Pot_and_Intergenic.txt
  - step7_intergenic_pot_lncRNas.sh



