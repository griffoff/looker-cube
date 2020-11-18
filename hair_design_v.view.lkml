view: prestige_hair_design_v {
  derived_table: {
    sql: SELECT DISTINCT COURSEKEY,MAX(LAST_SCORE_MODIFIED_TIME::date) as last_updated_score
      FROM PROD.REPORTS.hair_design_academy
      WHERE COURSEKEY IN (
        SELECT coursekey FROM prod.dw_ga.dim_course_v
         WHERE institutionid IN ('1840','1263039')
          AND IFNULL(enddate,'9999-01-01') >= DATEADD(DAY, -14, CURRENT_DATE))
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

  dimension: last_updated_score {
    type: date
    sql: ${TABLE}."LAST_UPDATED_SCORE" ;;
  }

  set: detail {
    fields: [coursekey, last_updated_score]
  }
}
