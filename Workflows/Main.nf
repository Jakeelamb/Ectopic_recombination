#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Import processes from other files
include { download_genomes } from './download_genomes' // Download the raw genomes
include { download_rawreads } from './download_rawreads' // Download the raw reads
include { prep_files1 } from './prep_files1' // Prepare files (unzip the files)
include { trim_raw_filt_mito } from './trim_raw_filt_mito' // Trim and filter mito from raw reads
include { dnaPipeTE } from './dnaPipeTE' // Run dnaPipeTE
include { ltr_pipeline } from './ltr_pipeline' //Run the LTR pipeline
include { prep_files2 } from './prep_files2' // Prepare files (create directories & split Fastas)
include { index_and_map } from './index_and_map' // Index the LTRs and map the trimmed reads
include { coverage_analysis } from './coverage_analysis' // Calculate the read coverage
include { ectopic_recomb } from './ectopic_recomb' // Collect results and visualize

// Define the input channel from the Lookup_table.txt file
lookup_ch = Channel
    .fromPath('Lookup_table.txt')
    .splitCsv(header: true, sep: '\t')
    .map { row -> tuple(row.Species, row.Genome_Accession, row.SRA_Accesssion) }


//Define Global Variables
base_dir = "/nfs/home/jlamb/Projects/nextflow_ltr"
genome_dir = "${base_dir}/Data/Genomes"
rawreads_dir="${base_dir}/Data/Raw_reads/"
trimmed_reads_dir="${base_dir}/Data/Trimmed_reads/"
ltr_dir="${base_dir}/Data/LTRs"



workflow {
    download_genomes(lookup_ch.map { it.Genome_Accession })
    download_rawreads(lookup_ch.map { it.SRA_Accession })
    prep_files1()
    trim_raw_filt_mito()
    dnaPipeTE()
    ltr_pipeline()
    prep_files2()
    index_and_map()
    coverage_analysis()
    ectopic_recomb()
}
