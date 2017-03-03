view: fact_activation_siteusage {
  label: "Activations - Site Usage"
  derived_table: {
    sql:
      select CourseId, PartyId, ProductId, ProductPlatformId,UserId
        ,sum(ClickCount) as Clicks
        ,sum(PageViewTime) / 1000.0 as PageViewTime_secs
        ,avg(PageViewTime) / 1000.0 as Avg_PageViewTime_secs
      from migration_test.dw_ga.fact_siteusage
      group by 1, 2, 3, 4, 5;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden:  yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden:  yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden:  yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden:  yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden:  yes
  }

  measure: user_count {
    label: "# Users"
    type:  count_distinct
    sql: ${userid} ;;
  }

  measure: site_usage_percent_of_activations{
    label: "site usage % of activations"
    type: number
    value_format_name: percent_1
    sql: ${user_count}/${fact_activation.user_count} ;;
  }

  measure: pageviewtime_total {
    label: "Page view Time (secs)"
    type: sum
    sql: ${TABLE}.PageViewTime_secs ;;
  }

  measure: pageviewtime_avg {
    label: "Avg Page view Time (secs)"
    type: average
    sql: ${TABLE}.Avg_PageViewTime_secs ;;
  }

  measure:test {
    type:  number
    sql: ${user_count} / ${fact_activation.user_count} ;;
  }

}
