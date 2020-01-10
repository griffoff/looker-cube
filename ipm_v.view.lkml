view: ipm_v {
  derived_table: {
    sql: select EVENT_TIME,MESSAGE_TYPE from IPM.PROD.IPM_CAMPAIGN
      group by 1,2
      UNION ALL
      select EVENT_TIME,MESSAGE_TYPE from IPM.PROD.IPM_QUEUE_EVENT
      group by 1,2
      UNION ALL
      select EVENT_TIME,MESSAGE_TYPE from IPM.PROD.IPM_BROWSER_EVENT
      group by 1,2
      order by 1 desc
       ;;
  }

  measure: count {
    type: count
    label: "Event_Count"
    drill_fields: [detail*]
  }

  dimension_group: event_time {
    type: time
    label:"Event_Time"
    timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
  }

  dimension: message_type {
    type: string
    label: "Message_Type"
    sql: ${TABLE}."MESSAGE_TYPE" ;;
  }

  set: detail {
    fields: [event_time_time, message_type]
  }
}
