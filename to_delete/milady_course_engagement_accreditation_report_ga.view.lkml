view: milady_course_engagement_accreditation_report_ga {
  sql_table_name: REPORTS.MILADY_COURSE_ENGAGEMENT_ACCREDITATION_REPORT_GA ;;

  dimension: applicationname {
    type: string
    sql: ${TABLE}.APPLICATIONNAME ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: duration_pageinstanceid {
    type: number
    value_format_name: id
    sql: ${TABLE}.DURATION_PAGEINSTANCEID ;;
  }

  dimension: duration_sessionnumber {
    type: number
    sql: ${TABLE}.DURATION_SESSIONNUMBER ;;
  }

  dimension: duration_student {
    type: number
    sql: ${TABLE}.DURATION_STUDENT ;;
  }

  dimension: duration_week {
    type: number
    sql: ${TABLE}.DURATION_WEEK ;;
  }

  dimension: effectivescore {
    type: number
    sql: ${TABLE}.EFFECTIVESCORE ;;
  }

  dimension: engagement_level {
    type: string
    sql: ${TABLE}.ENGAGEMENT_LEVEL ;;
  }

  dimension: first_login {
    type: string
    sql: ${TABLE}.FIRST_LOGIN ;;
  }

  dimension: fname {
    type: string
    sql: ${TABLE}.FNAME ;;
  }

  dimension: isbn13 {
    type: string
    sql: ${TABLE}.ISBN13 ;;
  }

  dimension: last_login {
    type: string
    sql: ${TABLE}.LAST_LOGIN ;;
  }

  dimension: learningactivity {
    type: string
    sql: ${TABLE}.LEARNINGACTIVITY ;;
  }

  dimension: learningpathid {
    type: number
    value_format_name: id
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension: lname {
    type: string
    sql: ${TABLE}.LNAME ;;
  }

  dimension: Full_Name{
    label: "Full Name"
    type: string
    sql: ${fname}|| ' ' || ${lname} ;;
  }

  dimension: pageinstanceid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PAGEINSTANCEID ;;
  }

  dimension: pct_of_activities_accessed {
    type: string
    sql: ${TABLE}.PCT_OF_ACTIVITIES_ACCESSED ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension: sessionnumber {
    type: number
    sql: ${TABLE}.SESSIONNUMBER ;;
  }

  dimension: student_guid {
    type: string
    sql: ${TABLE}.STUDENT_GUID ;;
  }

  dimension: weekname {
    type: string
    sql: ${TABLE}.WEEKNAME ;;
  }

  measure: count {
    type: count
    drill_fields: [fname, lname, applicationname, weekname]
  }
}
