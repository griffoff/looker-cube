connection: "snowflake_prod"

# include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

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


# explore: fivetran_audit {}


# explore: engagementsource_marketing{
#   label: "engagement_marketing"
#   extends: [dim_course]
#   join:  dim_course {
#     sql_on: ${dim_course.coursekey} = ${engagementsource_marketing.coursekey} ;;
#     relationship: many_to_one
#   }
# }

# explore: new_mt_gtm_events {}



# explore: Pat_usage {
#   label: "Usage Data -  Apps in MindTap Learning Path"
#   from: fact_siteusage
#   description: "Explore Start point for learning path usage from the student persepctive including application usage information collected via google analytics."
#   extends: [dim_user, dim_course, dim_pagedomain, dim_learningpath]
#   fields: [ALL_FIELDS*,
#     -Pat_usage.percent_of_all_activations,-Pat_usage.percent_of_activations,-Pat_usage.clickcount_avg,-Pat_usage.clickcount,-Pat_usage.session_number,-Pat_usage.sourcedata
#     ,-fact_activityoutcome.points_earned,-fact_activityoutcome.points_possible,-Pat_usage.firsteventdate,-Pat_usage.lasteventdate,-Pat_usage.count_session,-fact_activityoutcome.score_avg,
#     -fact_activityoutcome.completed_activities,-fact_activityoutcome.usercount,-fact_activityoutcome.usercount_withscore,-fact_activityoutcome.takestartdate,-fact_activityoutcome.completed
#     ,-product_facts.product_users,-product_facts.activations_for_isbn,-product_facts.activated_courses_for_isbn,-course_section_facts.total_users
#     ,-dim_user.numberofvisits,-dim_user.productsactivated
#     ,-user_facts.gradable_activities_completed_by_user,-user_facts.activities_completed_by_user
#     ,-dim_learningpath.node_id,-lp_node_map.snapshotid,-dim_learningpath.snapshot_status
#     ,-dim_activity_view_uri.path,-dim_activity.estimated_minutes,-dim_activity.activityid
#     ,-mindtap_lp_activity_tags.total_activity_activations
#     ,-Pat_usage.usercount,-Pat_usage.total_users
#     ,-fact_activityoutcome.score_to_final_score_correlation
#     ,-Pat_usage.time_on_task_to_final_score_correlation]
#
#   join: dim_course {
#     sql_on: ${Pat_usage.courseid} = ${dim_course.courseid} ;;
#     relationship: many_to_one
#     type: full_outer
#     fields: [dim_course.curated_fields*]
#   }
#
#   join: paid_users {
#     view_label: "User"
#     sql_on: (${Pat_usage.courseid}, ${Pat_usage.userid}) = (${paid_users.courseid}, ${paid_users.userid}) ;;
#     relationship: many_to_one
#   }
#
#   join: dim_location {
#     sql_on: ${Pat_usage.locationid} = ${dim_location.locationid} ;;
#     relationship: many_to_one
#     fields: [dim_location.curated_fields*]
#   }
#
#   join: dim_activity {
#     sql_on: ${Pat_usage.activityid} = ${dim_activity.activityid} ;;
#     relationship: many_to_one
#     fields: [dim_activity.curated_fields_WL*]
#   }
#
#   join: dim_learningpath {
#     sql_on: ${Pat_usage.learningpathid} = ${dim_learningpath.learningpathid} ;;
#     relationship: many_to_one
#     fields: [dim_learningpath.curated_fields*]
#   }
#
#   join: dim_party {
#     sql_on: ${Pat_usage.partyid} = ${dim_party.partyid} ;;
#     relationship: many_to_one
#     fields: [dim_party.curated_fields*]
#   }
#
#   join: dim_user {
#     sql_on: ${Pat_usage.userid} = ${dim_user.userid} ;;
#     relationship: many_to_one
#     fields: [dim_user.curated_fields*]
#   }
#
#   join: dim_pagedomain {
#     sql_on: ${Pat_usage.pagedomainid} = ${dim_pagedomain.pagedomainid} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_relative_to_start_date {
#     sql_on: ${Pat_usage.daysfromcoursestart} = ${dim_relative_to_start_date.days} ;;
#     relationship: many_to_one
#   }
#
#   join: fact_activityoutcome {
#     sql_on: ${Pat_usage.learningpathid} = ${fact_activityoutcome.learningpathid}
#           and ${Pat_usage.userid} = ${fact_activityoutcome.userid}
#           and ${Pat_usage.eventdatekey} = ${fact_activityoutcome.startdatekey}
#           ;;
#     relationship: many_to_many
#   }
#
# #   join: fact_appusage_by_user {
# #     view_label: ""
# #     sql_on: (${Pat_usage.courseid},${Pat_usage.userid}) = (${fact_appusage_by_user.courseid},${fact_appusage_by_user.userid}) ;;
# #     relationship: one_to_many
# #     fields: [curated_fields_WL*]
# #   }
# #
# #   join: dim_iframeapplication {
# #     sql_on: ${fact_appusage_by_user.iframeapplicationid} = ${dim_iframeapplication.iframeapplicationid};;
# #     relationship: many_to_one
# #     fields: [curated_fields_WL*]
# #   }
#
#   # join: dim_iframeapplication_map {
#   #   from: dim_iframeapplication
#   #   fields: [dim_iframeapplication_map.iframeapplicationid]
#   #   sql_on: ${dim_iframeapplication.iframeapplicationid} = ${dim_iframeapplication_map.iframeapplicationid_group};;
#   #   relationship: many_to_one
#   # }
#
#   # join: fact_appusage {
#   #   sql_on: (${fact_appusage_by_user.courseid}, ${fact_appusage_by_user.userid}, ${dim_iframeapplication_map.iframeapplicationid}) = (${fact_appusage.courseid}, ${fact_appusage.userid}, ${fact_appusage.iframeapplicationid})  ;;
#   #   relationship: one_to_many
#   #   fields: [curated_fields_WL*]
#   # }
#
#   join: dim_deviceplatform {
#     sql_on: ${Pat_usage.deviceplatformid} = ${dim_deviceplatform.deviceplatformid} ;;
#     relationship: many_to_one
#   }
#
#   join: course_section_facts {
#     fields: [course_section_facts.curated_fields*]
#   }
#   join: user_facts {
#     fields: [user_facts.curated_fields*]
#   }
#   join: dim_activity_view_uri {
#     fields: [dim_activity_view_uri.curated_field*]
#   }
#   join: mindtap_lp_activity_tags {
#     fields: [mindtap_lp_activity_tags.WL_fields*]
#   }
#   join: dim_product {
#     fields: [dim_product.curated_fields*]
#   }
# # join: fact_session {
# #   sql_on: (${fact_appusage.deviceplatformid},${WL_usage.timekey},${dim_user.userid}) = (${fact_session.deviceplatformid},${fact_session.timekey},${fact_session.userid}) ;;
# #   type: inner
# # }
# }




# explore: activities_per_week {
#   label: "Trial Period Abuse"
# }

# explore: activities_per_week {
#   extends: [dim_course]
#   label: "Student Assignment Completion"
#   description: "Data set used as base for trial period abuse investigation"
#   join: dim_course {
#     sql_on: ${activities_per_week.courseid} = ${dim_course.courseid};;
#     relationship: many_to_one
#   }
# }
