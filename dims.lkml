#connection: "snowflake_prod"
#  connection should/must be defined in other models that include this model
#
#  This model is for EXTENSIONREQUIRED explores only
#  These are used for dimension links that can be include in other explores
#  to get additional relatied dimensions for free
#
#

include: "dim_*.view.lkml"         # include all views in this project
include: "fact_*.view.lkml"
include: "custom_filters.*.view.lkml"
# include: "stg_clts.olr_courses.view.lkml"
include: "location.view.lkml"
include: "UPLOADS.mindtap_lp_activity_tags.view.lkml"
# include: "stg_clts.products.view.lkml"
include: "*facts.view.lkml"
include: "courseinstructor.view.lkml"

# include all views from project source in this model
include: "//project_source/*.view.lkml"


#include: "*.dashboard.lookml"  # include all dashboards in this project

case_sensitive: no

explore:  dim_product {
  label: "Product"
  extension: required
  hidden:  no

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

  join: dim_productplatform {
    relationship: many_to_one
    sql_on: ${products.platform} = ${dim_productplatform.productplatformkey} ;;
  }
}



explore: dim_course {
  hidden: no
  label: "Course"
  extension: required
  extends: [dim_institution, dim_product, course_keys_filter_all]

  join: olr_courses {
    fields: [olr_courses.curated_fields*]
    sql_on: ${dim_course.coursekey} = ${olr_courses.context_id};;
    relationship: one_to_one
    #fields: [olr_courses.curated_fields*]
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
    sql_on: ${dim_course.course_entity_id} = ${dim_institution.entity_no} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    relationship: many_to_one
    sql_on: ${dim_course.coursekey} = ${dim_filter.course_key} ;;
  }

  join:  course_section_facts {
    sql_on: ${dim_course.courseid} = ${course_section_facts.courseid} ;;
    relationship: one_to_one
  }

  join:  product_facts {
    sql_on: ${course_section_facts.by_product_fk} = ${product_facts.by_product_fk} ;;
    relationship: many_to_one
  }

  join: courseinstructor {
    sql_on: ${olr_courses.course_key} = ${courseinstructor.coursekey} ;;
    relationship: many_to_many
  }

  join: course_keys_filter_all {
    sql_on: ${olr_courses.course_key} = ${course_keys_filter_all.course_key} ;;
    #type: full_outer
    relationship: one_to_one
  }

}

explore: dim_date {
  extension: required
  hidden:  no
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

#   join: ipeds_map {
#     sql_on: ${dim_institution.entity_no} = ${ipeds_map.entity_no} ;;
#     relationship: one_to_one
#   }

#   join: ipeds {
#     sql_on: ${ipeds_map.ipeds_id} = ${ipeds.unit_id} ;;
#     relationship: many_to_one
#   }
}

explore: dim_deviceplatform {
  extension: required
  hidden:  no
}

explore: dim_eventtype {
  extension: required
  hidden:  no
}

explore: dim_learningpath {
  extension: required
  hidden:  no

  join: dim_master_first_used_date {
    view_label: "Learning Path"
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
    sql_on: (UPPER(${dim_product.productfamily}),${dim_product.edition_number},${dim_learningpath.activity_title_key})=(UPPER(${mindtap_lp_activity_tags.product_family}),${mindtap_lp_activity_tags.edition_number},${mindtap_lp_activity_tags.activity_title_key});;
    relationship: many_to_many
  }
}

explore: dim_location {
  extension: required
  hidden:  no

  join: location {
    type: left_outer
    sql_on: ${dim_location.locationid} = ${location.locationid} ;;
    relationship: many_to_one
  }
}

explore: dim_pagedomain {
  extension: required
  hidden:  no

  join: dim_productplatform {
    sql_on: ${dim_pagedomain.productplatformid} = ${dim_productplatform.productplatformid} ;;
    relationship: many_to_one
  }
}

#- explore: dim_party

explore:  dim_user {
  extension: required
  hidden:  no

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
