view: ebook_usage_v {


    derived_table: {
      sql: SELECT * FROM DM_EBOOK_USAGE.PROD_REPORTS_V1.HIST_CU_EBOOK_ROYALTY_REPORT
        ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension_group: activity_date {
      type: time
      sql: ${TABLE}."ACTIVITY_DATE" ;;
    }

    dimension: source {
      type: string
      sql: ${TABLE}."SOURCE" ;;
    }

    dimension: activity_count {
      type: number
      sql: ${TABLE}."ACTIVITY_COUNT" ;;
    }

    set: detail {
      fields: [activity_date_time, source, activity_count]
    }
  }
