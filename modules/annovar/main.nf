process ANNOVAR_ANNOTATE {
    publishDir params.publish_dir, mode: 'copy'


    input:

      tuple val(datasetID), val(patientID), val(sampleID), path(vcf_File)


    output:

      tuple val(datasetID), val(patientID), val(sampleID), path("$datasetID/$patientID/$sampleID/ANNOVAR/annovar.hg38_multianno.txt"), path("$datasetID/$patientID/$sampleID/ANNOVAR/annovar.hg38_multianno.vcf.gz")

    script:

    """

    mkdir -p $datasetID/$patientID/$sampleID/ANNOVAR
    gzip -dc $vcf_File > vcf_File



    perl $params.db/table_annovar.pl \\
    vcf_File \\
    $params.humandb \\
    -buildver $params.buildver \\
    -out $datasetID/$patientID/$sampleID/ANNOVAR/annovar \\
    -protocol refGene \\
    -operation g \\
    -nastring . \\
    -vcfinput \\
    -polish \\
    -remove \\
    -thread 4


    bcftools view $datasetID/$patientID/$sampleID/ANNOVAR/annovar.hg38_multianno.vcf -Oz -o  $datasetID/$patientID/$sampleID/ANNOVAR/annovar.hg38_multianno.vcf.gz



    """
}
