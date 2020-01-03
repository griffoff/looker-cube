view: iam_v {
  derived_table: {
    sql: select EVENT_TIME::date as date,
              COUNT(*) AS COUNT, message_type as source from IAM.PROD.USER_MUTATION
 group by 1,3
 union all
 select EVENT_TIME::date as date,
              COUNT(*) AS COUNT, message_type as source from IAM.PROD.credentials_used
 group by 1,3
 order by 1 desc
 ;;
  }

  dimension_group: event_time {
    type: time
    label:"Event"
    timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
  }

  dimension: message_type {
    type: string
    label: "Source"
    sql: ${TABLE}.message_type ;;
  }

  measure: count {
    label: "# Count"
    type: count
  }

}
