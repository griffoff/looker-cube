connection: "snowflake_prod"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

include: "dims*"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: WL_usage {
  label: "World languages Usage Data"
  from: fact_siteusage
  description: "Explore Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath]
#   fields: [dim_eventaction.eventactionid,WL_usage.usercount,WL_usage.total_users,WL_usage.pageviewtime_useraverage,
#             WL_usage.pageviewtime_sum,dim_cla_item*,dim_product.curated_fields*,WL_usage.eventdatekey]
join: dim_eventaction  {
  sql_on: ${dim_eventaction.eventactionid} = ${WL_usage.eventactionid} ;;
  relationship: one_to_many
  type: inner
    }
  join: dim_cla_item {
    sql_on: ${WL_usage.learningpathid} = ${dim_cla_item.learningpathid};;
    relationship: many_to_one
    type: inner
  }

  join: dim_course {
    sql_on: ${WL_usage.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
    fields: [dim_course.curated_fields*]
  }
#
#     join: dim_product {
#       sql_on: ${LP_Siteusage_Analysis.productid} = ${dim_product.productid} ;;
#       relationship: many_to_one
#       fields: [dim_product.curated_fields*]
#     }
#
  join: dim_location {
    sql_on: ${WL_usage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
    fields: [dim_location.curated_fields*]
  }

  join: dim_activity {
    sql_on: ${WL_usage.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
    fields: [dim_activity.curated_fields_WL*]
  }

  join: dim_learningpath {
    sql_on: ${WL_usage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
    fields: [dim_learningpath.curated_fields*]
  }

  join: dim_party {
    sql_on: ${WL_usage.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
    fields: [dim_party.curated_fields*]
  }

  join: dim_time {
    sql_on: ${WL_usage.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${WL_usage.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
    fields: [dim_user.curated_fields*]
  }

  join: dim_pagedomain {
    sql_on: ${WL_usage.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${WL_usage.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: fact_activityoutcome {
    sql_on: ${WL_usage.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${WL_usage.userid} = ${fact_activityoutcome.userid}
          and ${WL_usage.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

  join: fact_appusage_by_user {
    sql_on: (${WL_usage.courseid},${WL_usage.userid}) = (${fact_appusage_by_user.courseid},${fact_appusage_by_user.userid}) ;;
    relationship: one_to_many
    type: inner
  }

  join: dim_iframeapplication {
    sql_on: ${fact_appusage_by_user.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid};;
    relationship: many_to_one
  }

  join: dim_iframeapplication_map {
    from: dim_iframeapplication
    fields: [dim_iframeapplication_map.iframeapplicationid]
    sql_on: ${dim_iframeapplication.iframeapplicationid} = ${dim_iframeapplication_map.iframeapplicationid_group};;
    relationship: many_to_one
  }

  join: fact_appusage {
    sql_on: (${fact_appusage_by_user.courseid}, ${fact_appusage_by_user.userid}, ${dim_iframeapplication_map.iframeapplicationid}) = (${fact_appusage.courseid}, ${fact_appusage.userid}, ${fact_appusage.iframeapplicationid})  ;;
    relationship: one_to_many
    fields: [curated_fields_WL*]
  }

  join: dim_deviceplatform {
    sql_on: ${fact_appusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

join: course_section_facts {
  fields: [course_section_facts.curated_fields*]
}
join: user_facts {
  fields: [user_facts.curated_fields*]
}
join: dim_activity_view_uri {
  fields: [dim_activity_view_uri.curated_field*]
}
join: mindtap_lp_activity_tags {
  fields: [mindtap_lp_activity_tags.WL_fields*]
}
join: dim_product {
  fields: [dim_product.curated_fields*]
}
}
