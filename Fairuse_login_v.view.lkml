view: fairuse_login_v {
  # # You can specify the table name if it's different from the view name:
     derived_table: {
      sql: select LOCAL_TIME,
      COUNT(*) AS COUNT from FAIRUSE.PROD.RAW_LOGINS
      group by 1,2
      order by 1 desc
      }

    dimension_group: local_time {
      type: time
      label:"LOCAL_TIME"
      timeframes: [raw, year, month, month_name, week, week_of_year, date, time, hour, hour_of_day, minute]
    }

    dimension: message_type {
      type: string
      label: "MESSAGE_TYPE"
      sql: ${TABLE}.MESSAGE_TYPE ;;
    }



  measure: count {
    label: "# Count"
    type: count
  }

  }
