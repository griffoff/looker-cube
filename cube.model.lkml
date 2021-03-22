include: "//core/common.lkml"
#include: "//project_source/*.view.lkml"
include: "//core/access_grants_file.view"


connection: "snowflake_prod"
label:"Cube Data on Looker"

datagroup: fact_siteusage_datagroup {
  sql_trigger: SELECT COUNT(*) FROM dw_ga.fact_siteusage;;
}

datagroup: fact_activityoutcome_datagroup {
  sql_trigger: SELECT COUNT(*) FROM dw_ga.fact_activityoutcome;;
}

datagroup: daily_refresh {
  sql_trigger: SELECT CURRENT_DATE() ;;
}

#include dims model
include: "dims.lkml"
# include all the views
include: "/*.view"





# include all the dashboards
# include: "/cube/*dashboard.lookml*"



explore: fact_activation {
  label: "Activations"
  description: "Starting point for specific activations-related questions (e.g. how many activations do we have per product by institution?)."
  extends: [dim_course]
  fields: [ALL_FIELDS*,-dim_productplatform.productplatform_all]

  join: course_section_facts {
    fields: []
  }

  join: dim_date {
    from: dim_activation_date
    sql_on: ${fact_activation.activationdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
    #view_label: "Date - Activation Date"
  }

  join: dim_activationfilter {
    sql_on: ${fact_activation.activationfilterid} = ${dim_activationfilter.activationfilterid} ;;
    relationship: many_to_one
  }

  join: dim_activationregion {
    sql_on: ${fact_activation.activationregionid} = ${dim_activationregion.activationregionid} ;;
    relationship: many_to_one
  }

  #override product platform from course (the activation might be counted under a different platform)
  join: dim_productplatform {
    sql_on: ${fact_activation.productplatformid} = ${dim_productplatform.productplatformid} ;;
  }
#
   join: dim_user {
     sql_on: ${fact_activation.userid} = ${dim_user.userid} ;;
     relationship: many_to_one
   }

 join: dim_party {
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
     relationship: many_to_one
   }

#   join: user_facts {
#     sql_on: ${dim_user.userid} = ${user_facts.userid} ;;
#     relationship: one_to_one
#   }
#
  join: dim_course {
    #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${fact_activation.courseid} = ${dim_course.courseid} ;;
    type: full_outer
    relationship: many_to_one
  }

  join: dim_product {
     sql_on: ${fact_activation.productid} = ${dim_product.productid} ;;
     relationship: many_to_one
   }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activation.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

join: fact_activation_siteusage {
    sql_on: ${fact_activation.courseid} = ${fact_activation_siteusage.courseid};;
    relationship: many_to_one
  }

join: lifespan {
  sql_on: (${dim_institution.entity_no}, ${products.prod_family_cd}) = (${lifespan.entity_no}, ${lifespan.prod_family_cd}) ;;
  relationship: many_to_one
  }

join: gateway_institution {
  view_label: "Institution"
  sql_on: ${dim_institution.entity_no}  = ${gateway_institution.entity_no};;
  relationship: many_to_one
}

}


explore: fact_activity {
  label: "Learning Path - MT Instructor Modifications DEV"
  description: "Starting point for learning path analysis from the instructor perspective (e.g. What has the instructor changed?  What has the instructor added?)"
  from: dim_course
  view_name: dim_course

  extends: [dim_course, dim_learningpath]
  fields: [ALL_FIELDS*, -dim_activity.percent_usage, -fact_siteusage.time_on_task_to_final_score_correlation]

  join: fact_activity {
    #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${dim_course.courseid} = ${fact_activity.courseid} ;;
    relationship: one_to_many
  }

  join: dim_eventtype {
    sql_on: ${fact_activity.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
    relationship: many_to_one
  }

  join: dim_created_date {
    sql_on: ${fact_activity.createddatekey} = ${dim_created_date.datekey} ;;
    relationship: many_to_one
  }

  join: dim_instructor_user {
    from: dim_user
    view_label: "User (Instructor)"
    sql_on: ${fact_activity.userid} = ${dim_instructor_user.userid} ;;
    relationship: many_to_one
  }

  join: dim_instructor_party {
    from: dim_party
    view_label: "User (Instructor)"
    sql_on: ${dim_instructor_user.mainpartyid} = ${dim_instructor_party.partyid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_activity.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${fact_activity.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

#   join: dim_course {
#     #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
#     sql_on: ${fact_activity.courseid} = ${dim_course.courseid} ;;
#     relationship: many_to_one
#     type: full_outer
#   }

  join: courseinstructor {
    sql_on: ${olr_courses.course_key} = ${courseinstructor.coursekey} ;;
    relationship: many_to_many
  }

#    join:  fact_activityoutcome {
#      sql_on: (${dim_course.courseid}, ${dim_activity.activityid}) = (${fact_activityoutcome.courseid}, ${fact_activityoutcome.activityid}) ;;
#      relationship: one_to_many
#    }

  join:  fact_siteusage {
    sql_on: (${fact_activity.courseid}, ${fact_activity.learningpathid}) = (${fact_siteusage.courseid}, ${fact_siteusage.learningpathid}) ;;
    relationship: many_to_many
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_activity.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

#   join: dim_relative_to_end_date {
#     sql_on: ${fact_activity.daysbeforecourseend} = ${dim_relative_to_end_date.days} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${fact_activity.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${dim_course.coursekey} = ${dim_filter.course_key} ;;
    relationship: many_to_one
  }

}

explore:  fact_appusage_by_user {
  from: dim_course
  view_name: dim_course
  extends: [dim_course, dim_user, dim_learningpath]
  label: "App dock usage - Mindtap"
  description: "
  Usage metrics about mindapps accessed via the Mindtap app dock
  Does not include usage of apps accessed via inline activities (from the learning path)
  "


  join: fact_appusage_by_user {
    sql_on: ${fact_appusage_by_user.courseid} = ${dim_course.courseid} ;;
    relationship: one_to_many
    #type: full_outer
    #fields: [dim_course.curated_fields*]
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
}



explore: fact_siteusage {
  from: dim_course
  view_name: dim_course
  extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath]
  label: "Learning Path - MT Usage Data DEV"
  description: "Start point for learning path usage from the student persepctive including application usage information collected via google analytics."

  join: fact_siteusage {
    sql_on:  ${dim_course.courseid} = ${fact_siteusage.courseid} ;;
    relationship: one_to_many
  }

  join: dim_date {
    from: dim_activity_date
    sql_on: ${fact_siteusage.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
  }

  join: user_final_scores {
    sql_on: (${fact_siteusage.courseid}, ${fact_siteusage.partyid}) = (${user_final_scores.courseid}, ${user_final_scores.partyid}) ;;
    relationship: many_to_one
  }

  join: dim_product {
    sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
    relationship: many_to_one
  }

  join: dim_location {
    sql_on: ${fact_siteusage.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
  }

  join: dim_activity {
    sql_on: ${fact_siteusage.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
  }

  join: dim_learningpath {
    sql_on: ${fact_siteusage.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
  }

#   join: dim_master_node {
#     sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid} ;;
#     relationship: many_to_one
#   }

  join: dim_party {
    sql_on: ${fact_siteusage.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
  }

  join: lms_user_info {
    from: lms_user_info
    sql_on: ${dim_party.guid} = ${lms_user_info.uid};;
    relationship:  one_to_many
    type:  left_outer
  }

  join: dim_user {
    sql_on: ${fact_siteusage.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
  }

  join: user_scores_daily {
    sql_on: (${dim_course.courseid}, ${dim_party.partyid}, ${dim_relative_to_start_date.days}) = (${user_scores_daily.courseid}, ${user_scores_daily.partyid}, ${user_scores_daily.day_of_course})  ;;
    relationship: many_to_one
  }

  join: dim_deviceplatform {
    sql_on: ${fact_siteusage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
  }

#   join: dim_product {
#     sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${fact_siteusage.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
  }

  join: dim_pagedomain {
    sql_on: ${fact_siteusage.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
  }

  join: dim_relative_to_start_date {
    sql_on: ${fact_siteusage.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: fact_activityoutcome {
    sql_on: ${fact_siteusage.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${fact_siteusage.userid} = ${fact_activityoutcome.userid}
          and ${fact_siteusage.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

  join: paid_users {
    view_label: "User"
    sql_on: (${fact_siteusage.courseid}, ${fact_siteusage.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
    relationship: many_to_one
  }

  join: activity_usage_facts {
#     view_label: "Activity Facts"
    sql_on: (${activity_usage_facts.courseid},${activity_usage_facts.activity_usage_facts_grouping},${activity_usage_facts.partyid})
      = (${fact_siteusage.courseid},${mindtap_lp_activity_tags.activity_usage_facts_grouping},${fact_siteusage.partyid}) ;;
    relationship: many_to_many

}
  join: activity_chapter_usage_facts {
#     view_label: "Activity Chapter Usage Facts"
    sql_on: (${activity_chapter_usage_facts.courseid},${activity_chapter_usage_facts.chapter},${activity_chapter_usage_facts.partyid})
      = (${fact_siteusage.courseid},${mindtap_lp_activity_tags.chapter},${fact_siteusage.partyid}) ;;
    relationship: many_to_many

  }
}

explore: LP_Analysis_PSR_Limited_View {
  label: "Learning Path Analysis - Pilot Tagging Explore"
  from: fact_siteusage
  description: "TEST Explore Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
  extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath, dim_product]
  fields: [ALL_FIELDS*, -dim_activity.percent_usage, -fact_activityoutcome.score_to_final_score_correlation, -LP_Analysis_PSR_Limited_View.time_on_task_to_final_score_correlation]

  join: dim_date {
    view_label: "Date - Date of activity"
    sql_on: ${LP_Analysis_PSR_Limited_View.eventdatekey} = ${dim_date.datekey} ;;
    relationship: many_to_one
    fields: [dim_date.curated_fields*]
    #fields: [datevalue_date,datevalue_week,datevalue_month,datevalue_month_name,datevalue_year,datevalue_day_of_week,fiscalyear,count,]
  }

  join: dim_course {
    sql_on: ${LP_Analysis_PSR_Limited_View.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
    fields: [dim_course.curated_fields*]
  }

  join: dim_product {
    fields: [dim_product.curated_fields*]
  }

  join: dim_location {
    sql_on: ${LP_Analysis_PSR_Limited_View.locationid} = ${dim_location.locationid} ;;
    relationship: many_to_one
    fields: [dim_location.curated_fields*]
  }

  join: dim_activity {
    sql_on: ${LP_Analysis_PSR_Limited_View.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
    fields: [dim_activity.curated_fields*]
  }

  join: dim_learningpath {
    sql_on: ${LP_Analysis_PSR_Limited_View.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
    fields: [dim_learningpath.curated_fields*]
  }

#   join: dim_master_node {
#     sql_on: ${fact_siteusage.masternodeid} = ${dim_master_node.masternodeid} ;;
#     relationship: many_to_one
#   }

  join: dim_party {
    sql_on: ${LP_Analysis_PSR_Limited_View.partyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
    fields: [dim_party.curated_fields*]
  }

  join: dim_user {
    sql_on: ${LP_Analysis_PSR_Limited_View.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
    fields: [dim_user.curated_fields*]
  }

  join: dim_deviceplatform {
    sql_on: ${LP_Analysis_PSR_Limited_View.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
    relationship: many_to_one
    fields: []
  }

#   join: dim_product {
#     sql_on: ${fact_siteusage.productid} = ${dim_product.productid} ;;
#     relationship: many_to_one
#   }

  join: dim_time {
    sql_on: ${LP_Analysis_PSR_Limited_View.timekey} = ${dim_time.timekey} ;;
    relationship: many_to_one
    fields: []
  }

  join: dim_pagedomain {
    sql_on: ${LP_Analysis_PSR_Limited_View.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
    relationship: many_to_one
    fields: []
  }

  join: dim_relative_to_start_date {
    sql_on: ${LP_Analysis_PSR_Limited_View.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: fact_activityoutcome {
    sql_on: ${LP_Analysis_PSR_Limited_View.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${LP_Analysis_PSR_Limited_View.userid} = ${fact_activityoutcome.userid}
          and ${LP_Analysis_PSR_Limited_View.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
    relationship: many_to_many
  }

  join: paid_users {
    view_label: "User"
    sql_on: (${LP_Analysis_PSR_Limited_View.courseid}, ${LP_Analysis_PSR_Limited_View.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
    relationship: many_to_one
  }

  join: olr_courses {
    fields: [olr_courses.curated_fields*]
  }

  join: course_section_facts {
    fields: [course_section_facts.curated_fields*]
  }

  join: dim_institution {
    fields: [dim_institution.curated_fields*]
  }

  join: ipeds {
    fields: []
  }

  join: user_facts {
    fields: [user_facts.curated_fields*]
  }

}
  explore: LP_Siteusage_Analysis {
    label: "Learning Path Analysis - MT Usage Data"
    from: dim_course
    view_name: dim_course

#     fields: [LP_Siteusage_Analysis.curated_fields*,dim_course.curated_fields*,dim_product.curated_fields*,dim_location.curated_fields*,dim_activity.curated_fields_PM*
#       ,dim_learningpath.curated_fields*,dim_party.curated_fields*,dim_user.curated_fields*,activity_usage_facts.curated_fields*,activity_chapter_usage_facts.curated_fields*,
#       course_section_facts.curated_fields*,user_facts.curated_fields*,dim_activity_view_uri.curated_field*,mindtap_lp_activity_tags.curated_fields*]
    description: "Explore Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
    extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath]
    fields: [ALL_FIELDS*, -dim_activity.percent_usage, -fact_activityoutcome.score_to_final_score_correlation, -LP_Siteusage_Analysis.time_on_task_to_final_score_correlation]

    join: LP_Siteusage_Analysis {
      from: fact_siteusage
      sql_on: ${dim_course.courseid} = ${LP_Siteusage_Analysis.courseid} ;;
      relationship: many_to_one
      #fields: [dim_course.curated_fields*]
    }

    join: user_activity_buckets {
      sql_on: ${LP_Siteusage_Analysis.userid} = ${user_activity_buckets.userid}
      and ${LP_Siteusage_Analysis.courseid} = ${user_activity_buckets.courseid};;
      relationship: many_to_one
    }
#
#     join: dim_product {
#       sql_on: ${LP_Siteusage_Analysis.productid} = ${dim_product.productid} ;;
#       relationship: many_to_one
#       fields: [dim_product.curated_fields*]
#     }
#
    join: dim_location {
      sql_on: ${LP_Siteusage_Analysis.locationid} = ${dim_location.locationid} ;;
      relationship: many_to_one
      fields: [dim_location.curated_fields*]
    }

    join: dim_activity {
      sql_on: ${LP_Siteusage_Analysis.activityid} = ${dim_activity.activityid} ;;
      relationship: many_to_one
      fields: [dim_activity.curated_fields_PM*]
    }

    join: dim_learningpath {
      sql_on: ${LP_Siteusage_Analysis.learningpathid} = ${dim_learningpath.learningpathid} ;;
      relationship: many_to_one
      fields: [dim_learningpath.curated_fields*]
    }

    join: dim_party {
      sql_on: ${LP_Siteusage_Analysis.partyid} = ${dim_party.partyid} ;;
      relationship: many_to_one
      fields: [dim_party.curated_fields*]
    }

    join: dim_user {
      sql_on: ${LP_Siteusage_Analysis.userid} = ${dim_user.userid} ;;
      relationship: many_to_one
      fields: [dim_user.curated_fields*]
    }

    # Can we join in guid_cohot view for custom cohort creation here??
    # Jia request

   join: dim_pagedomain {
      sql_on: ${LP_Siteusage_Analysis.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
      relationship: many_to_one
    }

    join: dim_relative_to_start_date {
      sql_on: ${LP_Siteusage_Analysis.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
      relationship: many_to_one
    }

    join: fact_activityoutcome {
      sql_on: ${LP_Siteusage_Analysis.learningpathid} = ${fact_activityoutcome.learningpathid}
          and ${LP_Siteusage_Analysis.userid} = ${fact_activityoutcome.userid}
          and ${LP_Siteusage_Analysis.eventdatekey} = ${fact_activityoutcome.startdatekey}
          ;;
      relationship: many_to_many
      fields: [fact_activityoutcome.curated_fields*]
    }

    join: activity_usage_facts {
#       view_label: "Activity Facts"
      sql_on: (${activity_usage_facts.courseid},${activity_usage_facts.activity_usage_facts_grouping},${activity_usage_facts.partyid})
        = (${LP_Siteusage_Analysis.courseid},${mindtap_lp_activity_tags.activity_usage_facts_grouping},${LP_Siteusage_Analysis.partyid}) ;;
      relationship: many_to_many
      fields: [activity_usage_facts.curated_fields*]
    }
    join: activity_chapter_usage_facts {
#       view_label: "Activity Chapter Usage Facts"
      sql_on: (${activity_chapter_usage_facts.courseid},${activity_chapter_usage_facts.chapter},${activity_chapter_usage_facts.partyid})
        = (${LP_Siteusage_Analysis.courseid},${mindtap_lp_activity_tags.chapter},${LP_Siteusage_Analysis.partyid}) ;;
      relationship: many_to_many
      fields: [activity_chapter_usage_facts.curated_fields*]
    }
    join: paid_users {
      view_label: "User"
      sql_on: (${LP_Siteusage_Analysis.courseid}, ${LP_Siteusage_Analysis.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
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
      fields: [mindtap_lp_activity_tags.curated_fields*]
    }
    join: dim_product {
      fields: [dim_product.curated_fields*]
    }

  }

explore: LP_Activity_Analysis {
  from: fact_activity
  label: "Learning Path Analysis - MT Instructor Modifications"
  description: "Starting point for learning path analysis from the instructor perspective (e.g. What has the instructor changed?  What has the instructor added?)"
  extends: [dim_course, dim_learningpath]

  join: dim_eventtype {
    sql_on: ${LP_Activity_Analysis.eventtypeid} = ${dim_eventtype.eventtypeid} ;;
    relationship: many_to_one
    fields: [dim_eventtype.curated_fields*]
  }

  join: dim_user {
#     from: dim_user
    view_label: "Course / Section Details"
    sql_on: ${LP_Activity_Analysis.userid} = ${dim_user.userid} ;;
    relationship: many_to_one
    fields: [dim_user.curated_fields_for_instructor_mod*]
  }

#   join: dim_instructor_party {
  join: dim_party{
#     from: dim_party
    view_label: "User (Instructor)"
    sql_on: ${dim_user.mainpartyid} = ${dim_party.partyid} ;;
    relationship: many_to_one
    fields: [dim_party.curated_fields_for_instructor_mod*]
  }

  join: dim_learningpath {
    sql_on: ${LP_Activity_Analysis.learningpathid} = ${dim_learningpath.learningpathid} ;;
    relationship: many_to_one
    fields: [dim_learningpath.curated_fields*]
  }

  join: dim_activity {
    sql_on: ${LP_Activity_Analysis.activityid} = ${dim_activity.activityid} ;;
    relationship: many_to_one
    fields: [dim_activity.curated_fields_PM*]
  }

  join: dim_course {
    #sql: right join dw_ga.dim_course on ${courseid} = ${dim_course.courseid} ;;
    sql_on: ${LP_Activity_Analysis.courseid} = ${dim_course.courseid} ;;
    relationship: many_to_one
    type: full_outer
    fields: [dim_course.curated_fields*]
  }

  join: courseinstructor {
    sql_on: ${olr_courses.course_key} = ${courseinstructor.coursekey} ;;
    relationship: many_to_many
  }

  join:  fact_siteusage {
    view_label: "Learning Path"
    sql_on: (${LP_Activity_Analysis.courseid}, ${LP_Activity_Analysis.learningpathid}) = (${fact_siteusage.courseid}, ${fact_siteusage.learningpathid}) ;;
    relationship: many_to_many
    fields: [fact_siteusage.curated_fields_for_instructor_mod*]
  }

  join: dim_relative_to_start_date {
    sql_on: ${LP_Activity_Analysis.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    sql_on: ${dim_course.coursekey} = ${dim_filter.course_key} ;;
    relationship: many_to_one
  }
  join: course_section_facts {
    fields: [course_section_facts.curated_fields*]
  }
  join: mindtap_lp_activity_tags {
    fields: [mindtap_lp_activity_tags.curated_fields*]
  }
  join: dim_activity_view_uri {
    fields: [dim_activity_view_uri.curated_field*]
  }
  join: lp_node_map {
    fields: [lp_node_map.curated_fields_PM*]
  }
  join: dim_product {
    fields: [dim_product.curated_fields*]
  }
}

# explore: guided_course_setup_instructor_vs_dss {
#   from: mt_courses_gcs_setup_status
#   label: "Guided Course Setup"

#   join: guided_course_setup {
#     sql_on: ${guided_course_setup_instructor_vs_dss.course_key} = ${guided_course_setup.course_key} ;;
#     relationship: one_to_many
#   }

#   join: mt_courses_fall2020 {
#     sql_on:  ${guided_course_setup_instructor_vs_dss.course_key} =  ${mt_courses_fall2020.course_key};;
#   }
#   }



  explore: mt_courses_gcs_setup_status {
    label: "Guided Course Setup (product info)"

    join: dim_product {
      sql_on: ${mt_courses_gcs_setup_status.isbn} = ${dim_product.isbn13} ;;
    }
  }

explore: mt_courses_fall2020 {
  label: "Guided Course Setup"

    join: mt_courses_gcs_setup_status {
      sql_on: ${mt_courses_fall2020.course_key} = ${mt_courses_gcs_setup_status.course_key};;
    }

  join: guided_course_setup {
    sql_on: ${mt_courses_gcs_setup_status.course_key} = ${guided_course_setup.course_key} ;;
    relationship: one_to_many
}
}



# explore: fact_appusage {
#   label: "App Usage Troubleshoot"
#   join: dim_iframeapplication  {
#     sql_on: ${fact_appusage.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid} ;;
#   }
# }


explore: ga_data_parsed {
  label: "Google Analytics Data"
  extends: [dim_course]
  join: user_facts {
    relationship: many_to_one
    sql_on: ${ga_data_parsed.userssoguid} = ${user_facts.guid} ;;
  }
  join: user_final_scores {
    sql_on: (${dim_course.courseid}, ${ga_data_parsed.userssoguid}) = (${user_final_scores.courseid}, ${user_final_scores.sso_guid}) ;;
    relationship: many_to_one
  }
  join: olr_courses {
    fields: []
    relationship: many_to_one
    sql_on: split_part(${ga_data_parsed.courseuri}, ':', -1) = ${olr_courses.cgi} ;;
  }
  join: dim_course {
    relationship: many_to_one
    sql_on: COALESCE(${olr_courses.context_id}, ${ga_data_parsed.coursekey}) = ${dim_course.coursekey} ;;
  }
  join: dim_product_1 {
    fields: []
    from: dim_product
    sql_on: ${dim_course.productid} = ${dim_product_1.productid}   ;;
    relationship: many_to_one
  }
  join: dim_product_2 {
    fields: []
    from: dim_product
    sql_on: ${ga_data_parsed.coretextisbn} = ${dim_product_2.isbn13}
      and ${dim_product_1.isbn13} IS NULL;;
    relationship: one_to_many
  }
  join: dim_product {
    sql_on: COALESCE(${dim_product_1.productid}, ${dim_product_2.productid}) = ${dim_product.productid} ;;
    relationship: one_to_one
  }
  join: dim_relative_to_start_date {
    relationship: many_to_one
    sql_on: datediff(days, ${olr_courses.begin_date_date}, ${ga_data_parsed.hit_date}) = ${dim_relative_to_start_date.days} ;;
  }
}


explore: datavault_test_report {}


explore: olr_nonolr_combined_user_activations {}
explore: olr_nonolr_combined_user_activations_wkly {}
explore: qa_rental_v {}
