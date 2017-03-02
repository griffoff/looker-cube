view: fact_activation_siteusage {
  label: "Site Usage"
  sql_table_name: LOOKER_WORKSHOP.FACT_ACTIVATION_SITEUSAGE ;;

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

}
