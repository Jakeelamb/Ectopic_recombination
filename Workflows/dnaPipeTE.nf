#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.Genome_Accension) }

process DOWNLOAD_GENOME {
    conda 'ERC'
    cpus 16
    clusterOptions = "--job-name=dnaPipeTE_{species}"   
 
    input:
    tuple val(species), val(accession)
    
    output:
    path ""
   
    publishDir params.genome_dir, mode: 'copy' 
   
    script:
    """
    









    """
}

workflow {
    dnaPipeTE(lookup_ch)
}
