#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.SRA_Accession) }

process download_rawreads {
    conda 'ERC'
    cpus 2
    time '4h'
    errorStrategy 'retry'
    maxRetries 3

    clusterOptions = "--job-name=SRA_fetch_${species}"

    input:
    tuple val(species), val(accession)

    output:
    tuple val(species), path("${accession}*.fastq"), emit: fastq_files

    publishDir params.rawreads_dir, mode: 'copy'

    script:
    """
    mkdir -p ${params.rawreads_dir}
    prefetch -O ${params.rawreads_dir} -f yes ${accession}
    fastq-dump --outdir ${params.rawreads_dir} --split-files ${accession}
    """
}

workflow {
    download_rawreads(lookup_ch)
}
