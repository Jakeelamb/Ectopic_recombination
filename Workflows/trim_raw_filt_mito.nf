#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.Genome_Accension) }

process trim_raw_filt_mito {
    conda 'ERC'
    
    cpus 1
    time '1h'
    clusterOptions = "--job-name=download_{species}"   
 
    input:
    tuple val(species), val(accession)
    
    output:
    path "${species}.zip"
   
    publishDir params.genome_dir, mode: 'copy' 
   
    script:
    """
    datasets download genome accession ${accession} --filename ${species}.zip
    """
}

workflow {
    trim_raw_filt_mito(lookup_ch)
}
