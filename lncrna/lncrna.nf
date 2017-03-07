/* 
 * Nextflow based lncRNA pipeline
 * 
 * Authors (based on the results from the lncRNA FAANG group)
 * Daniel Fischer <daniel.fischer@luke.fi>
 */ 

 
/*
 * Defines some parameters 
 */
params.reads = "$baseDir/ownCloud/NextflowDocker/lncrnadata/ExampleData/Reads/*_{1,2}.fastq.gz"
params.annot = "$baseDir/ownCloud/NextflowDocker/lncrnadata/ExampleData/Annotations/Ensembl79_UMD3.1_genes.gff3.gz"
params.genome = "$baseDir/ownCloud/NextflowDocker/lncrnadata/ExampleData/References/UMD3.1_chromosomes.fa.gz"
params.outdir = 'results'


log.info "l n c R N A   P I P E L I N E    "
log.info "================================="
log.info "reads              : ${params.reads}"
log.info "genome             : ${params.genome}"
log.info "annotation         : ${params.annot}"
log.info "outdir             : ${params.outdir}"

/*
 * the reference genome file
 */

genome_file = file(params.genome)
annotation_file = file(params.annot)

/*
 * Create the `read_pairs` channel that emits tuples containing three elements:
 * the pair ID, the first read-pair file and the second read-pair file 
 */

Channel
    .fromFilePairs( params.reads )
/*  .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }
    .set { read_pairs } 

/*
 * Step 1. Builds the genome index required by the mapping process
 */    
    
process buildIndex {
    tag "$genome_file.baseName"
    
    input:
    file genome_file
     
    output:
    file 'genome.index*' into genome_index
       
    """
    STAR --runThreadN 1 --runMode genomeGenerate --genomeDir Genome_data/star --genomeFastaFiles ${genome_file}
    """
}