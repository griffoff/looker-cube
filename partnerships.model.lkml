connection: "snowflake_prod"

include: "//core/common.lkml"
include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

include: "dims*"

explore:  fact_appusage_by_user {
  extends: [dim_course, dim_user, dim_learningpath]
  label: "Usage Data - App Dock"
  description: "
  Usage metrics about mindapps accessed via the Mindtap app dock
  Does not include usage of apps accessed via inline activities (from the learning path)
  "
  fields: [ALL_FIELDS*
   ,-product_facts.product_users,-product_facts.activations_for_isbn,-product_facts.activated_courses_for_isbn,-course_section_facts.total_users
  ,-course_section_facts.productplatformid,-course_section_facts.date_granularity
  ,-fact_appusage.click_per_user_buckets,-fact_appusage.filterflag,-fact_appusage.app_rank_user,-fact_appusage.app_rank
  ,-dim_user.productsactivated,-dim_user.numberofvisits
  ,-dim_activity_view_uri.ref_id,-dim_activity_view_uri.view_uri
  ,-dim_learningpath.snapshot_status,-lp_node_map.snapshotid
  ,-dim_party.count
  ,-user_facts.activities_completed_by_user,-user_facts.gradable_activities_completed_by_user
  ,- dim_iframeapplication.iframeapplicationname]

  join: dim_course {
    sql_on: ${fact_appusage_by_user.courseid} = ${dim_course.courseid} ;;
    relationship: one_to_one
    type: full_outer
    fields: [dim_course.curated_fields*]
  }

  join: dim_iframeapplication {
    sql_on: ${fact_appusage_by_user.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid};;
    relationship: many_to_one
  }

  join: dim_iframeapplication_map {
    view_label: "App Map"
    from: dim_iframeapplication
    fields: [dim_iframeapplication_map.iframeapplicationid]
    sql_on: ${dim_iframeapplication.iframeapplicationid} = ${dim_iframeapplication_map.iframeapplicationid_group};;
    relationship: many_to_one
  }

  join: dim_user {
    sql_on: ${fact_appusage_by_user.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
    fields: [dim_user.curated_fields*]
  }

  join: fact_appusage {
    sql_on: (${fact_appusage_by_user.courseid}, ${fact_appusage_by_user.userid}, ${dim_iframeapplication_map.iframeapplicationid}) = (${fact_appusage.courseid}, ${fact_appusage.userid}, ${fact_appusage.iframeapplicationid})  ;;
    relationship: one_to_many
  }

  join: dim_learningpath {
    sql_on: ${fact_appusage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
    fields: [dim_learningpath.curated_fields*]
  }

  join: dim_location {
    type: left_outer
    sql_on: ${fact_appusage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: dim_date {
    from: dim_app_usage_date
    sql_on: ${fact_appusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  #override dim_course join type for performance
  join: dim_start_date {
    type: inner
  }

  join: dim_deviceplatform {
    sql_on: ${fact_appusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: datediff(day, to_date(nullif(${dim_course.startdatekey}, -1)::string, 'YYYYMMDD'), to_date(nullif(${fact_appusage.eventdatekey}, -1)::string, 'YYYYMMDD')) = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }
  join: user_facts {
    fields: [user_facts.curated_fields*]
  }
  join: mindtap_lp_activity_tags {
    fields: [mindtap_lp_activity_tags.WL_fields*]
    }
}
