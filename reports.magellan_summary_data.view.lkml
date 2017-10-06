view: magellan_summary_data {
  sql_table_name: REPORTS.MAGELLAN_SUMMARY_DATA ;;

  dimension: avg_instructor_logins_per_week {
    type: number
    sql: ${TABLE}.AVG_INSTRUCTOR_LOGINS_PER_WEEK ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: instructor_avg_timespent_per_login {
    type: number
    sql: ${TABLE}.INSTRUCTOR_AVG_TIMESPENT_PER_LOGIN ;;
  }

  dimension: instructor_guid {
    type: string
    sql: ${TABLE}.INSTRUCTOR_GUID ;;
  }

  dimension: instructor_total_timespent {
    type: number
    sql: ${TABLE}.INSTRUCTOR_TOTAL_TIMESPENT ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: loginrecency {
    type: string
    sql: ${TABLE}.LOGINRECENCY ;;
  }

  dimension: sent_flag {
    type: yesno
    sql: ${TABLE}.SENT_FLAG ;;
  }

  dimension: student_avg_logins_per_week {
    type: number
    sql: ${TABLE}.STUDENT_AVG_LOGINS_PER_WEEK ;;
  }

  dimension: student_avg_timespent_per_login {
    type: number
    sql: ${TABLE}.STUDENT_AVG_TIMESPENT_PER_LOGIN ;;
  }

  dimension: student_avg_total_logins {
    type: number
    sql: ${TABLE}.STUDENT_AVG_TOTAL_LOGINS ;;
  }

  dimension: student_avg_total_timespent {
    type: number
    sql: ${TABLE}.STUDENT_AVG_TOTAL_TIMESPENT ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
