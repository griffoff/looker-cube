view: fairuse_login_v {
  # # You can specify the table name if it's different from the view name:
    sql_table_name:FAIRUSE.PROD.RAW_LOGINS;;

    dimension_group: LOCAL_TIME {
      type: time
      label:"activity_date"
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
