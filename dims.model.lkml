connection: "snowflake_migration_test"

#
#  This model is for EXTENSIONREQUIRED explores only
#  These are used for dimension links that can be include in other explores
#  to get additional relatied dimensions for free
#
#

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore:  dim_product {
  label: "Product"

  join:  productfamilymap {
    sql_on: ${dim_product.productfamily} = ${productfamilymap.prod_family_description} ;;
    relationship: many_to_one
  }
  join: activations_dashboard_20170330 {
    sql_on: ${dim_product.discipline} = ${activations_dashboard_20170330.discipline}   ;;
    relationship: many_to_one
  }

  join: activations_from_JW {
    sql_on: ${activations_dashboard_20170330.discipline} = ${activations_from_JW.discipline}   ;;
    relationship: many_to_one
  }
}

explore: dim_course {
  label: "Course"
  extension: required
  extends: [dim_institution, dim_product]

  join: course_facts {
    sql_on: ${dim_course.courseid} = ${course_facts.courseid} ;;
    relationship: one_to_one
  }

  join: dim_start_date {
    sql_on: ${dim_course.startdatekey} = ${dim_start_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_end_date {
    sql_on: ${dim_course.enddatekey} = ${dim_end_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_product {
    relationship: many_to_one
    sql_on: ${dim_course.productid} = ${dim_product.productid} ;;
  }

  join: dim_institution {
    relationship: many_to_one
    sql_on: ${dim_course.institutionid} = ${dim_institution.institutionid} ;;
  }

  join: dim_productplatform {
    relationship: many_to_one
    sql_on: ${dim_course.productplatformid} = ${dim_productplatform.productplatformid} ;;
  }

  join: dim_filter {
    relationship: many_to_one
    sql_on: ${dim_course.filterflag} = ${dim_filter.filterflag} ;;
  }
}

explore: dim_date {
  extension: required
  extends: [fact_session, fact_siteusage]

  join: fact_session {
    sql_on: ${dim_date.datekey} = ${fact_session.eventdatekey} ;;
    relationship: one_to_many
  }

  join: fact_siteusage {
    sql_on: ${dim_date.datekey} = ${fact_siteusage.eventdatekey} ;;
    relationship: one_to_many
  }

  join: fact_activation {
    sql_on: ${dim_date.datekey} = ${fact_activation.activationdatekey} ;;
    relationship: one_to_many
  }

  join: fact_enrollment {
    sql_on: ${dim_date.datekey} = ${fact_enrollment.eventdatekey} ;;
    relationship: one_to_many
  }
}

explore: dim_institution {
  extension: required

  join: dim_location {
    sql_on: ${dim_institution.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }
}

explore: dim_deviceplatform {
  extension: required
}

explore: dim_eventtype {
  extension: required
}

explore: dim_learningpath {
  extension: required
  #- join: parentlearningpath
  #  type: left_outer
  #  sql_on: ${dim_learningpath.parentlearningpathid} = ${parentlearningpath.parentlearningpathid}
  #  relationship: many_to_one
  join: dim_master_node {
    sql_on: ${dim_learningpath.masternodeid} = ${dim_master_node.masternodeid} ;;
    relationship: many_to_one
  }

  join: dim_first_used_date {
    sql_on: ${dim_master_node.first_used_datekey} = ${dim_first_used_date.datekey} ;;
    relationship: many_to_one
  }
}

explore: dim_location {
  extension: required

  join: location {
    type: left_outer
    sql_on: ${dim_location.locationid} = ${location.locationid} ;;
    relationship: many_to_one
  }
}

explore: dim_pagedomain {
  extension: required

  join: dim_productplatform {
    sql_on: ${dim_pagedomain.productplatformid} = ${dim_productplatform.productplatformid} ;;
    relationship: many_to_one
  }
}

#- explore: dim_party

explore: dim_user {
  extension: required

  join: dim_party {
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: user_facts {
    sql_on: ${dim_user.userid} = ${user_facts.userid} ;;
    relationship: one_to_one
  }
}
