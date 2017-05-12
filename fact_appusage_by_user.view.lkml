view: fact_appusage_by_user {
  view_label: "App Dock"
  derived_table: {
    sql:
      select
          row_number() over (order by 2, 3, 4) as pk
          ,a.partyid
          ,a.iframeapplicationid
          ,a.courseid
          ,sum(clickcount) as appclicks
      FROM dw_ga.fact_appusage a
      group by 2,3,4
      ;;

      sql_trigger_value: select count(*) from dw_ga.fact_appusage ;;
  }

  dimension: pk {
    hidden: yes
    sql: ${TABLE}.pk ;;
    primary_key: yes
  }

  dimension: partyid {
    hidden: yes
    sql: ${TABLE}.partyid ;;
  }

  dimension: iframeapplicationid {
    hidden: yes
    sql: ${TABLE}.iframeapplicationid ;;
  }

  dimension: courseid {
    hidden: yes
    sql: ${TABLE}.courseid ;;
  }

  dimension: appclicks_base {
    type: number
    sql: ${TABLE}.appclicks ;;
    hidden: yes
  }

  dimension: appclick_bucket {
    label: "App usage buckets"
    type: tier
    style: integer
    tiers: [4, 8]
    sql: ${appclicks_base} ;;
  }

  measure: appclicks_avg {
    label: "Avg # Total app usage"
    description: "Average of Total no. of times a user used an app"
    type: average
    sql: ${appclicks_base} ;;
  }

}
