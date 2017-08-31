connection: "snowflake_prod"

#
#  This model is for EXTENSIONREQUIRED explores only
#  These are used for dimension links that can be include in other explores
#  to get additional relatied dimensions for free
#
#

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

case_sensitive: no

explore:  dim_product {
  label: "Product"
  extension: required

#   join: activations_dashboard_20170330 {
#     sql_on: ${dim_product.discipline} = ${activations_dashboard_20170330.discipline}   ;;
#     relationship: many_to_one
#     type: full_outer
#   }
#
#   join: activations_from_JW {
#     sql_on: ${activations_dashboard_20170330.discipline} = ${activations_from_JW.discipline}   ;;
#     relationship: many_to_one
#   }

  join: products {
    view_label: "Product"
    sql_on: ${dim_product.isbn13} = ${products.isbn13};;
    relationship:  one_to_one
    fields: [products.prod_family_cd, products.available_dt*, products.copyright_yr, products.prod_family_cd_edition]

  }
}

explore: dim_course {
  label: "Course"
  extension: required
  extends: [dim_institution, dim_product]

  join: olr_courses {
    sql_on: ${dim_course.coursekey} = ${olr_courses.context_id};;
    relationship: one_to_one
  }

  join: dim_start_date {
    sql_on: ${dim_course.startdatekey} = ${dim_start_date.datekey} ;;
    relationship: many_to_one
  }

#   join: dim_end_date {
#     sql_on: ${dim_course.enddatekey} = ${dim_end_date.datekey} ;;
#     relationship: many_to_one
#   }

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

  join:  course_section_facts {
    sql_on: ${dim_course.courseid} = ${course_section_facts.courseid} ;;
    relationship: one_to_one
  }

  join:  product_facts {
    sql_on: ${course_section_facts.by_product_fk} = ${product_facts.by_product_fk} ;;
    relationship: many_to_one
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
    view_label: "Institution"
    sql_on: ${dim_institution.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: ipeds_map {
    sql_on: ${dim_institution.entity_no} = ${ipeds_map.entity_no} ;;
    relationship: one_to_one
  }

  join: ipeds {
    sql_on: ${ipeds_map.ipeds_id} = ${ipeds.unit_id} ;;
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

  join: dim_master_first_used_date {
    view_label: "Date - Learning Path - Master First Use"
    from:  dim_date
    sql_on: ${dim_learningpath.master_first_used_datekey} = ${dim_master_first_used_date.datekey} ;;
    relationship: many_to_one
  }

  join: lp_node_map {
    sql_on: ${dim_learningpath.learningpathid} = ${lp_node_map.learningpathid} ;;
    relationship: one_to_many
  }

  join: dim_activity_view_uri {
    sql_on: ${dim_learningpath.node_id} = ${dim_activity_view_uri.id} ;;
    relationship: one_to_one
  }

  join: mindtap_lp_activity_tags {
    sql_on: (${dim_product.productfamily},${dim_product.edition_number},${dim_learningpath.lowest_level})=(${mindtap_lp_activity_tags.product_family},${mindtap_lp_activity_tags.edition_number},${mindtap_lp_activity_tags.learning_path_activity_title});;
    relationship: one_to_many
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

explore:  dim_user {
  extension: required

  join: dim_party {
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: user_facts {
    sql_on: ${dim_user.userid} = ${user_facts.userid} ;;
    relationship: one_to_one
  }

  join: fact_activation  {
    sql_on: (${dim_course.courseid}, ${dim_user.userid}) = (${fact_activation.courseid}, ${fact_activation.userid}) ;;
    relationship: one_to_one
    fields: [-fact_activation.ALL_FIELDS*]
  }
}

# explore: dim_activity {
#   extension: required
#   join: fact_activity {
#     sql_on: (${dim_course.courseid}, ${dim_activity.activityid}) = (${fact_activity.courseid}, ${fact_activity.activityid}) ;;
#     relationship:  one_to_many
#   }
#   join: dim_eventtype {
#     sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
#     relationship: many_to_one
#   }
# }
