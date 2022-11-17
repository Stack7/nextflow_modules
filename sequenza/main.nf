process SEQUENZA_EXTRACT {
    publishDir params.publish_dir

    // conda (params.enable_conda ? "bioconda::r-sequenza=3.0.0" : null)
    // container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //     'quay.io/biocontainers/r-sequenza:3.0.0--r41h3342da4_4':
    //     'biocontainers/sequenza/sequenza:3.0.0' }"
    
    input:
      path(seqzFile)  // as input the seqz files path

    output:
      path("$params.sample_id*")  // the outputs are all the files generated by sequenza.results

    script:
    def args = task.ext.args ?: ''
    def norm_method = args!='' && args.norm_method ? "$args.norm_method" : "median"
    def window = args!='' && args.window ? "$args.window" : "1e5"  // window
    def gamma = args!='' && args.gamma ? "$args.gamma" : "280"  // gamma
    def kmin = args!='' && args.kmin ? "$args.kmin" : "300"  // kmin
    def min_reads_baf = args!='' && args.min_reads_baf ? "$args.min_reads_baf" : "50"
    def min_reads = args!='' && args.min_reads ?  "$args.min_reads" : "50"
    def min_reads_normal = args!='' && args.min_reads_normal ? "$args.min_reads_normal": "15"
    def max_mut_types = args!='' && args.max_mut_types ? "$args.max_mut_types" : "1"

    def low_cell = args!='' && args.low_cell ? "$args.low_cell" : "0.1"
    def up_cell = args!='' && args.up_cell ? "$args.up_cell" : "1.0"
    def low_ploidy = args!='' && args.low_ploidy ? "$args.low_ploidy" : "1.0"
    def up_ploidy = args!='' && args.up_ploidy ? "$args.up_ploidy" : "7.0"
    def is_female = args!='' && args.is_female ? "$args.is_female" : "FALSE"

    def sample_id = args!='' && args.sample_id ? "$args.sample_id" : "$params.sample_id"
    // def out_dir = args!='' && args.out_dir ? "$args.out_dir" : "$params.publish_dir"
    
    """
    #!/usr/bin/env Rscript

    library(sequenza)

    # find th correct set of chromosomes, stored in the seqz
    tmp = read.seqz("$seqzFile")
    chromosomes = unique(tmp[["chromosome"]])

    # chromosomes = paste0("", 1:24)
    # if (as.logical("$is_female"))
    #   chromosomes = paste0("", 1:23)

    # seqzExt = readRDS("$baseDir/seqzExt.Rds")
    # paraSpace = readRDS("$baseDir/paraSpace_run.Rds")

    seqzExt <- sequenza.extract(
       file = "$seqzFile",
       chromosome.list = chromosomes,
       normalization.method = "$norm_method",
       window = as.numeric("$window"),
       gamma = as.integer("$gamma"),
       kmin = as.integer("$kmin"),
       min.reads.baf = as.integer("$min_reads_baf"),
       min.reads = as.integer("$min_reads"),
       min.reads.normal = as.integer("$min_reads_normal"),
       max.mut.types = as.integer("$max_mut_types")
    )

    paraSpace <- sequenza.fit(
      sequenza.extract = seqzExt,
      cellularity = seq(as.integer("$low_cell"), as.integer("$up_cell"), 0.01),
      ploidy = seq(as.integer("$low_ploidy"), as.integer("$up_ploidy"), 0.1),
      chromosome.list = chromosomes,
      female = as.logical("$is_female")
    )

    sequenza.results(
      sequenza.extract = seqzExt,
      cp.table = paraSpace,
      sample.id = "$sample_id",
      out.dir = "$sample_id",  # should it be the process folder?
      female = as.logical("$is_female")
    )
    """
}

