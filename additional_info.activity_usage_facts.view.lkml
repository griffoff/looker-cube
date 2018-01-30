view: activity_usage_facts {
  label: "Learning Path"

  derived_table: {
    explore_source: fact_siteusage {
      column: activity_usage_facts_grouping { field: mindtap_lp_activity_tags.activity_usage_facts_grouping }
      column: activity_type { field: mindtap_lp_activity_tags.activity_type }
      column: activity_by_group { field: mindtap_lp_activity_tags.activity_by_group }
      column: no_of_unique_activities { field: dim_learningpath.lowest_level_count_distinct }
      column: courseid { field: fact_siteusage.courseid }
      column: partyid { field: fact_siteusage.partyid }
#       filters: {
#         field: dim_start_date.fiscalyear
#         value: "FY17"
#       }
#       filters: {
#         field: dim_product.productfamily_edition
#         value: "CACIOPPO^, DISCOVERING PSYCH - 002"
#       }
      sort: {field: fact_siteusage.courseid}
    }
    datagroup_trigger: fact_siteusage_datagroup
  }

  set: curated_fields {fields:[activity_type_usage_bucket]}

  dimension: activity_usage_facts_grouping {
    hidden: yes
  }
  dimension: activity_type {}
  dimension: activity_by_group {}
  dimension: no_of_unique_activities {}
  dimension: courseid {}
  dimension: partyid {}

  dimension: activity_type_usage_bucket{
    label: "Student Usage Bucket - By Activity Type"
    description: "Percent of activities accessed by a student in an Activity Type "
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
