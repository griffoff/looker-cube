view: fact_activation_siteusage {
  label: "Activations - Site Usage"
  derived_table: {
    sql:
      select CourseId
        ,avg(PageViewTime) / 1000.0 / /86400 as Avg_PageViewTime_days
        ,count(distinct userid) as user_count
        ,sum(pageViewTime) / 1000.0 / 86400 as Total_PageViewTime_days
        ,Total_PageViewTime_days / user_count as Avg_TimeInProductPerStudent
      from dw_ga.fact_siteusage
      group by 1;;

      sql_trigger_value: select count(*) from dw_ga.fact_siteusage ;;
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden:  yes
    primary_key: yes
  }

  measure: user_count {
    label: "# Users"
    description: "Count of distinct users who accessed a platform based on Google Analytics data"
    type:  sum
  }

  measure: Avg_TimeInProductPerStudent {
    label: "Avg total time in product"
    type: average
    value_format: "d hh:mm"
  }

  measure: site_usage_percent_of_activations{
    label: "Site Usage: % of activations"
    description: "% of users who accessed a platform based on Google Analytics data as a % of product activations.
      This indicates the number of actual users vs. potential users over the time frame specified in the filter section (denominator is 'Product Activations')."
    type: number
    value_format_name: percent_1
    sql: ${user_count}/${product_facts.activations_for_isbn} ;;
  }

  measure: pageviewtime_avg {
    label: "Avg Page view time"
    type: average
    sql: ${TABLE}.Avg_PageViewTime_days ;;
    value_format_name: duration_hms
  }


}