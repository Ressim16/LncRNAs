#load sleuth and other libraries
library("sleuth")
setwd("C:/Users/redaz/Documents/Uni/Master/RNA-seq/Steps/Step5/")
#load exp design and label kallisto outputs
base_dir <- "C:/Users/redaz/Documents/Uni/Master/RNA-seq/Steps/Step5/samples_step4/"
sample_id <- c("3_2","3_4","3_7","P1","P2","P3")
conditions<-c("Paraclonal", "Paraclonal", "Paraclonal", "control", "control", "control")
kal_dirs<-file.path(base_dir, sample_id)

#creating data.frame with path directory where files from kallisto are, and their conditions (Parental or Paraclonal here)
s2c<-data.frame(sample=sample_id,condition= conditions)
s2c <- dplyr::mutate(s2c, path = kal_dirs)



#library(biomaRt)
#library(BiocFileCache)
#collecting target ID to implement it into the so object (install biomart with bioconductor first, must have at least 4.3 version of R)
#mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL",dataset = "hsapiens_gene_ensembl", host = "https://ensembl.org")

#adding OVERSTACKFLOW
#t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name", "gene_biotype","transcript_biotype"), mart = mart)
#t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)

#importing t2g from cluster
t2g <- read.table("target_mapping_only.txt", sep=" ", header=F)
colnames(t2g)<- c("target_id", "gene_name", "gene_type")

###building sleuth object
##so object contains info about experiment and details of the model for DE testing
#loading kallisto data into the so object
so <- sleuth_prep(s2c, ~condition, target_mapping = t2g, extra_bootstrap_summary = TRUE, 
                  transformation_function = function(x) log2(x + 0.5),
                  )
#estimate parameters for the sleuth response error measurement model --> (full)
so <- sleuth_fit(so, ~condition, 'full')
#estimate parameters for the sleuth reduced model --> (reduced)
so <- sleuth_fit(so, ~1, 'reduced')
#perform DE analysis test using the Wald test (AND NOT THE LIKELIHOOD)
so <- sleuth_wt(so, 'conditionParaclonal')

###Examining results
#Viewing models() function
models(so)
#Viewing test's results
sleuth_table <- sleuth_results(so,'conditionParaclonal', show_all = F) #show_all = F does not display the genes that we didn't detect (we delete NA values)
sleuth_table_Known<-sleuth_table[!is.na(sleuth_table$gene_type),] #for known genes
sleuth_table_Novel<-sleuth_table[is.na(sleuth_table$gene_type),] #for new genes
#sleuth_table$log10qval<--log10(sleuth_table$qval)
sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)
#Table shows top 20 significant genes with a q-val <= 0.05
head(sleuth_significant, 20)



###Answering questions :

##We have to find the numbers of transcripts and genes
# that are differentially expressed between biological samples
sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)


##Generates statistics about the numbers of significantly
# up and down transcripts and genes (separately for known and novel)
# taking care with significance cutoffs (here 0.05 we use)
sleuth_significant_Novel<-sleuth_significant[is.na(sleuth_significant$gene_type),]
sleuth_significant_Known<-sleuth_significant[!is.na(sleuth_significant$gene_type),]
write.csv(sleuth_significant_Novel, file="Novel_Significant_DE_Genes.csv", row.names = F, quote = F)
write.csv(sleuth_significant_Known, file="Known_Significant_DE_Genes.csv", row.names = F, quote = F)



## Draw a volcano plot for appropriate comparisons
###Volcano Plot and other plots
library(EnhancedVolcano)
EnhancedVolcano(sleuth_table,
                lab=sleuth_table$target_id,
                x="b",
                y="qval")
#for only new transcripts
EnhancedVolcano(sleuth_table_Novel,
                lab=sleuth_table_Novel$target_id,
                x="b",
                y="qval")
#for only known genes and transcripts (I developed the aestetics for the report)
EnhancedVolcano(sleuth_table_Known,
                lab=sleuth_table_Known$gene_name,
                x="b",
                y="qval",
                title="DE of Annotated Genes between 2 conditions",
                pCutoff = 0.001788080,
                FCcutoff = 0.5,
                labSize=3.0,
                col=c("grey", "blue", "magenta", "red"),
                colAlpha = 1,
                legendLabels=c('Not sig.','Log (base 2) FC','p-value',
                               'p-value & Log (base 2) FC'),
                legendLabSize = 10,
                legendIconSize = 5.0,
                drawConnectors = TRUE,
                widthConnectors = 0.5,
                colConnectors = "grey40",
                max.overlaps = 20
                ) + coord_flip()

#Creating boxplots and taking one of the 20 genes and replace it in the 2nd argument below
# (I developed the aestetics for the report)
sleuth_significant_Known[sleuth_significant_Known$gene_name=="IL6",] #taking the ENST00000407492.2 target ID
plot_bootstrap(so, "ENST00000464710.2", units = "est_counts",
               color_by = "condition",
               x_axis_angle = 50)+
  scale_fill_manual(values=c("darkturquoise", "darkorchid"),
                    labels=c("Parental", "Paraclonal")) +
  ggtitle("Estimated counts for the IL6 gene")+
  ylab("Estimated counts")+
  xlab("Cell types")

#Creating PCA plot
plot_pca(so, color_by = 'condition')
#quality control to check the amount of counts per conditions --> should be the same
plot_group_density(so, use_filtered = TRUE, units = "est_counts",
                   trans = "log", grouping = setdiff(colnames(so$sample_to_covariates),
                                                     "sample"), offset = 1)

### Quality check: Do known/expected genes change as expected?
#we can analyse the volcano plot for known genes and 
# check if the genes are differntially expressed in lung cancer 
# e.g CXCL8 == ENST00000307407.8 (upregulated) and MYO10 == ENST00000513610.6 (downregulated) 
# also EGFR or MALAT1 or IL6 that are already well known in cancer implicaitons





