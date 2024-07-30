#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.Genome_Accession) }

process download_genomes {
    conda 'ERC'
    cpus 2
    time '2h'
    errorStrategy 'retry'
    maxRetries 3
    
    clusterOptions = "--job-name=download_${species}"
    
    input:
    tuple val(species), val(accession)
    
    output:
    path "${species.replaceAll(/[^a-zA-Z0-9]+/, '_')}.zip", emit: genome_zip
    
    publishDir params.genome_dir, mode: 'copy'
    
    script:
    """
    safe_species=\$(echo "${species}" | sed 's/[^a-zA-Z0-9]/_/g')
    datasets download genome accession ${accession} --filename \${safe_species}.zip
    
    if [ ! -f \${safe_species}.zip ]; then
        echo "Download failed for ${species}"
        exit 1
    fi
    """
}

workflow {
    download_genomes(lookup_ch)
}
