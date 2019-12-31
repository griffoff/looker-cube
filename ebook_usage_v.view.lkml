view: ebook_usage_v {
  derived_table: {
    sql: select distinct ACTIVITY_DATE::date as date,sum(ACTIVITY_COUNT) from prod.unlimited.cu_ebook_usage
        GROUP BY 1
         ORDER BY 1 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."DATE" ;;
  }

  dimension: sumactivity_count {
    type: number
    sql: ${TABLE}."SUM(ACTIVITY_COUNT)" ;;
  }

  set: detail {
    fields: [date, sumactivity_count]
  }
}
