view: activity_usage_facts {

  derived_table: {
    explore_source: fact_siteusage {
      column: activity_type { field: mindtap_lp_activity_tags.activity_type }
      column: activity_by_group { field: mindtap_lp_activity_tags.activity_by_group }
      column: no_of_unique_activities { field: dim_learningpath.lowest_level_count_distinct }
      column: courseid { field: dim_course.courseid }
      column: partyid { field: dim_party.partyid }
#       filters: {
#         field: dim_start_date.fiscalyear
#         value: "FY17"
#       }
#       filters: {
#         field: dim_product.productfamily_edition
#         value: "CACIOPPO^, DISCOVERING PSYCH - 002"
#       }
    }
    datagroup_trigger: fact_siteusage_datagroup
  }
  dimension: activity_type {}
  dimension: activity_by_group {}
  dimension: no_of_unique_activities {}
  dimension: courseid {}
  dimension: partyid {}

#   measure: UsageCount {
#     label: "Count of ActivityType By User"
#     type: count_distinct
#     sql: ${activity_type} ;;
# #    sql_distinct_key: ${partyid} ;;
#   }

  dimension: activity_type_usage_bucket{
    label: "Student Usage Bucket"
    type: string
    case: {
      when: {
        sql: COALESCE(${no_of_unique_activities},0) = 0 ;;
        label: "0-Nousage"
      }
      when: {
        sql: ${no_of_unique_activities} = 1;;
        label: "One Time usage"
      }
      when: {
        sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.25 ;;
        label: "25%"
      }
      when: {
        sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.5 ;;
        label: "50%"
      }
      when: {
        sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.75 ;;
        label: "75%"
      }
      else: "75%+"
    }
#     sql: CASE WHEN COALESCE(${no_of_unique_activities},0) = 0 THEN '0-Nousage'
#           WHEN ${no_of_unique_activities} = 1 THEN 'One Time usage'
#           WHEN ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.25 THEN '25%'
#           WHEN ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.5 THEN '50%'
#           WHEN ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_group} < 0.75 THEN '75%'
#           ELSE '75%+' END
#           ;;
#       order_by_field: bucket_sort
  }


}
