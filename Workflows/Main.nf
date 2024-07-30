#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Import processes from other files
include { Download_genomes } from './download_genomes' // Download the raw genomes
include { Download_RawReads } from './download_rawreads' // Download the raw reads
include { Prepare_files1 } from '.prep_files1' // Prepare files (unzip the files)
include { Trim_and_filter_mito } from '.trim_raw_filt_mito' // Trim and filter mito from raw reads
include { dnaPipeTE } from '.dnaPipeTE' // Run dnaPipeTE
include { LTR_Pipeline } from '.ltr_pipeline' //Run the LTR pipeline
include { Prepare_files2 } from '.prep_files2' // Prepare files (create directories & split Fastas)
include { Index_and_Map } from '.index_and_map' // Index the LTRs and map the trimmed reads
include { Coverage_analysis } from '.coverage_analysis' // Calculate the read coverage
include { Ectopic_recombination } from '.ectopic_recomb' // Collect results and visualize

workflow {
    Download_genomes()
    Download_RawReads()
    Prepare_files1()
    Trim_and_filter_mito()
    dnaPipeTE()
    LTR_Pipeline()
    Prepare_files2()
    Index_and_Map()
    Coverage_analysis()
    Ectopic_recombination()
}

/This is the main_workflow script
