#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> val(row.Genome_Accession) }

process download_genomes {
    conda 'ERC'
    cpus 2
    time '2h'
    errorStrategy 'retry'
    maxRetries 3

    clusterOptions = "--job-name=download_genome"

    input:
    val(accession)

    output:
    path "${accession}.zip", emit: genome_zip

    publishDir ${genome_dir}, mode: 'copy'

    script:
    """
    mkdir -p ${genome_dir}
    datasets download genome accession ${accession} --filename ${accession}.zip

    if [ ! -f ${accession}.zip ]; then
        echo "Download failed for ${accession}"
        exit 1
    fi
    """
}

workflow {
    download_genomes(lookup_ch)
}

