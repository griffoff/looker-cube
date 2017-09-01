view: magellan_data {
  sql_table_name: REPORTS.MAGELLAN_DATA ;;

  dimension: pk {
    sql: ${coursekey} || ${week_of_course} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: avg_instructor_logins_per_day {
    type: number
    sql: ${TABLE}.AVG_INSTRUCTOR_LOGINS_PER_DAY ;;
  }

  dimension: avg_instructor_timespent_per_login {
    type: number
    sql: ${TABLE}.AVG_INSTRUCTOR_TIMESPENT_PER_LOGIN ;;
  }

  dimension: avg_student_logins {
    type: number
    sql: ${TABLE}.AVG_STUDENT_LOGINS ;;
  }

  dimension: avg_student_timespent {
    type: number
    sql: ${TABLE}.AVG_STUDENT_TIMESPENT ;;
  }

  dimension: avg_student_timespent_per_login {
    type: number
    sql: ${TABLE}.AVG_STUDENT_TIMESPENT_PER_LOGIN ;;
  }

  dimension: count_instructor_days_logged_in {
    type: number
    sql: ${TABLE}.COUNT_INSTRUCTOR_DAYS_LOGGED_IN ;;
  }

  dimension: count_of_instructorlogin {
    type: number
    sql: ${TABLE}.COUNT_OF_INSTRUCTORLOGIN ;;
  }

  dimension: count_of_students {
    type: number
    sql: ${TABLE}.COUNT_OF_STUDENTS ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: coursestart {
    type: string
    sql: ${TABLE}.COURSESTART ;;
  }

  dimension: instructor_guid {
    type: string
    sql: ${TABLE}.INSTRUCTOR_GUID ;;
  }

  dimension: instructor_lastlogintime {
    type: string
    sql: ${TABLE}.INSTRUCTOR_LASTLOGINTIME ;;
  }

  dimension: instructor_totaltimespent {
    type: number
    sql: ${TABLE}.INSTRUCTOR_TOTALTIMESPENT ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: number_of_studentlogin {
    type: number
    sql: ${TABLE}.NUMBER_OF_STUDENTLOGIN ;;
  }

  dimension: productplatform {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORM ;;
  }

  dimension: sent_flag {
    type: yesno
    sql: ${TABLE}.SENT_FLAG ;;
  }

  dimension: student_totaltimespent {
    type: number
    sql: ${TABLE}.STUDENT_TOTALTIMESPENT ;;
  }

  dimension: week_of_course {
    type: number
    sql: ${TABLE}.WEEK_OF_COURSE ;;
  }

  dimension: weekcategory {
    type: string
    sql: ${TABLE}.WEEKCATEGORY ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
