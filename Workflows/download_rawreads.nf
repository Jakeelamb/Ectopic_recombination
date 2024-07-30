#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.SRA_Accension) }

process Download_rawreads {
    conda 'ERC'
    
    cpus 1
    time '2h'
    clusterOptions = "--job-name=SRA_fetch_{species}"   
 
    input:
    tuple val(species), val(accession)
    
    output:
    path
 
    publishDir params.rawreads_dir, mode: 'copy' 
   
    script:
    """
    prefetch -O ./Data/Rawreads -f {accension}
    fastq-dump --split-files {accension}
    """
}

workflow {
    Download_rawreads(lookup_ch)
}
