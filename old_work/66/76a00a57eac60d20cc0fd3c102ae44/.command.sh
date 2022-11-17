#!/usr/bin/env Rscript

    library(sequenza)

    chromosomes = paste0("", 1:24)
    print(chromosomes)
    if (as.logical("FALSE"))
      chromosomes = paste0("", 1:23)

    print(chromosomes)

    # seqzExt <- sequenza.extract(
    #   file = "mini.seqz.gz",
    #   chromosome.list = chromosomes,
    #   normalization.method = "median",
    #   window = as.numeric("1e5"),
    #   gamma = as.integer("280"),
    #   kmin = as.integer("300"),
    #   min.reads.baf = as.integer("50"),
    #   min.reads = as.integer("50"),
    #   min.reads.normal = as.integer("15"),
    #   max.mut.types = as.integer("1")
    # )

    seqzExt = readRDS("/mnt/c/Users/Elena/Desktop/tirocinio/repo/nextflow_modules/seqz_prova.Rds")

#    paraSpace <- sequenza.fit(
#      sequenza.extract = seqzExt,
#      cellularity = seq(as.integer("0.1"), as.integer("1.0"), 0.01),
#      ploidy = seq(as.integer("1.0"), as.integer("7.0"), 0.1),
#      chromosome.list = chromosomes,
#      female = as.logical("FALSE")
#    )

    paraSpace = readRDS("/mnt/c/Users/Elena/Desktop/tirocinio/repo/nextflow_modules/paraSpace_run.Rds")

    sequenza.results(
      sequenza.extract = seqzExt,
      cp.table = paraSpace,
      sample.id = "sampleid",
      out.dir = "/mnt/c/Users/Elena/Desktop/tirocinio/repo/nextflow_modules/out_files",  # should it be the process folder?
      female = as.logical("FALSE")
    )
