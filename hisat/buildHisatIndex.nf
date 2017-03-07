/* 
 * Nextflow based lncRNA pipeline
 * 
 * Authors (based on the results from the lncRNA FAANG group)
 * Daniel Fischer <daniel.fischer@luke.fi>
 */ 

 
/*
 * Defines some parameters 
 */
params.annotation = "/data/fromHost/bosTau8_Ens87_changed_chrNames.gtf"
params.genome = "/data/fromHost/bosTau8.fa"
params.outdir = "/data/fromHost"


log.info "Building HiSAT2 index"
log.info "================================="
log.info "annotation         : ${params.annotation}"
log.info "genome             : ${params.genome}"
log.info "outdir             : ${params.outdir}"

/*
 * the reference annotation file
 */

annotation_file = file(params.annotation)
genome_file = file(params.genome)

/*
 * Create the `read_pairs` channel that emits tuples containing three elements:
 * the pair ID, the first read-pair file and the second read-pair file 
 */

process extractSpliceSites {
    tag "$annotation_file.baseName"
    publishDir params.outdir, mode: 'copy'
    
    input:
    file annotation_file
     
    output:
    file 'splice_sites' into splice_sites
       
    """
      hisat2_extract_splice_sites.py ${annotation_file} > splice_sites
    """
}

process extractExons {
    tag "$annotation_file.baseName"
    publishDir params.outdir, mode: 'copy'
    
    input:
    file annotation_file
     
    output:
    file 'exons' into exons
       
    """
      hisat2_extract_exons.py ${annotation_file} > exons
    """
}

process buildIndex {
    tag "$annotation_file.baseName"
    publishDir params.outdir, mode: 'copy'
    
    input:
    file annotation_file
    file genome_file
    
    output:
    file '*.ht2' into ht2
       
    """
       hisat2-build -p 1 \
                --ss splice_sites \
                --exon exons \
                ${genome_file} HISATgenomes
    """
}


workflow.onComplete { 
	println ( workflow.success ? "Done!" : "Oops .. something went wrong" )
}