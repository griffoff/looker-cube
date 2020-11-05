view: champions_academy_v {
  derived_table: {
    sql: SELECT DISTINCT COURSEKEY,MAX(LAST_SCORE_MODIFIED_TIME::date) as last_score_dare
      FROM PROD.REPORTS.CHAMPIONS_BARBERING_INSTITUTE
      WHERE COURSEKEY IN(SELECT coursekey FROM prod.dw_ga.dim_course_v WHERE institutionid IN ('1241533') AND IFNULL(enddate,'9999-01-01') >= DATEADD(DAY, -14,CURRENT_DATE))
      GROUP BY 1
      ORDER BY 2 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}."COURSEKEY" ;;
  }

  dimension: last_score_dare {
    type: date
    sql: ${TABLE}."LAST_SCORE_DARE" ;;
  }

  set: detail {
    fields: [coursekey, last_score_dare]
  }
}
