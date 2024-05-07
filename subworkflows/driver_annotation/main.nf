//
// DRIVER_ANNOTATION SUB-WORKFLOW
//

include { ANNOTATE_DRIVER } from '../../modules/driver_annotation/main'


workflow DRIVER_ANNOTATION {
    take:
        rds
        driver_list
    
    main:
        ANNOTATE_DRIVER(rds, driver_list)


    emit:
        ANNOTATE_DRIVER.out.rds

}