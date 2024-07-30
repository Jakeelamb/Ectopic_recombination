#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Import processes from other files
include { DOWNLOAD_GENOMES } from './download_genomes'
include { Download_RawReads } from './download_rawreads'
include {
include { PROCESS2 } from './script2'
include { PROCESS3 } from './script3'
// ... include other processes as needed

workflow {
    DOWNLOAD_GENOMES()
    PROCESS2()
    PROCESS3()
    // ... call other processes as needed
}

/This is the main_workflow script
