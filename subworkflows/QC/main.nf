//
// QC SUB-WORKFLOW
//

include { CNAQC } from '../../modules/CNAqc/main'
include { JOIN_CNAQC } from '../../modules/join_CNAqc/main'


workflow QC {
    take: 
        cna
        vcf

    main:

        CNAQC(cna, vcf)
        JOIN_CNAQC(CNAQC.out.qc_rds.groupTuple(by: [0,1]))
    
    emit:
        rds_cnaqc = CNAQC.out.qc_rds
        plot_cnaqc_rds = CNAQC.out.plot_rds
        plot_cnaqc_data = CNAQC.out.plot_pdf_data
        plot_cnaqc_qc = CNAQC.out.plot_pdf_qc

        rds_join = JOIN_CNAQC.out.rds
}
