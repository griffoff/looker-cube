view: ebook_usage_v {
    derived_table: {
      sql:select ACTIVITY_DATE::date as date,sum(ACTIVITY_COUNT) as ACTIVITY_COUNT from prod.unlimited.cu_ebook_usage
group by 1
order by 1 desc
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

    dimension: activity_count {
      type: number
      sql: ${TABLE}."ACTIVITY_COUNT" ;;
    }

    set: detail {
      fields: [date, activity_count]
    }
  }
