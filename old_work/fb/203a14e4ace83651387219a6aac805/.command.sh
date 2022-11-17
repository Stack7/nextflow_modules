#!/usr/bin/env Rscript

    library(sequenza)

    chromosomes = paste0("chr", 1:24)
    print(chromosomes)
    if (as.logical("FALSE"))
      chromosomes = paste0("chr", 1:23)

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
    #   )

    load("/mnt/c/Users/Elena/Desktop/tirocinio/repo/nextflow_modules/40-VS-60_sequenza_extract.RData")

    paraSpace <- sequenza.fit(
      sequenza.extract = seqz_prova,
      cellularity = seq(as.integer("1"), as.integer("1"), 0.01),
      ploidy = seq(as.integer("1"), as.integer("1"), 0.1),
      chromosome.list = chromosomes,
      female = as.logical("FALSE")
      )

#    sequenza.results(
#      sequenza.extract = seqzExt,
#      cp.table = paraSpace,
#      sample.id = "",
#      out.dir = "/mnt/c/Users/Elena/Desktop/tirocinio/repo/nextflow_modules",  # should it be the process folder?
#      female = as.logical("FALSE")
#      )
