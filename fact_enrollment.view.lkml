view: fact_enrollment {
  label: "Enrollments"
  sql_table_name: DW_GA.FACT_ENROLLMENT ;;

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: daysbeforecourseend {
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
    hidden: yes
  }

  dimension: daysfromcoursestart {
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
    hidden: yes
  }

  measure: dropped {
    type: sum
    sql: ${TABLE}.DROPPED ;;
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  measure: enrollment {
    type: sum
    sql: ${TABLE}.ENROLLMENT ;;
  }

  dimension: enrollmentstatusid {
    type: string
    sql: ${TABLE}.ENROLLMENTSTATUSID ;;
    hidden: yes
  }

  dimension: eventdatekey {
    type: string
    sql: ${TABLE}.EVENTDATEKEY ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  measure: fullenrollment {
    label: "Full Enrollment"
    type: sum
    sql: ${TABLE}.FULLENROLLMENT ;;
  }

  measure: graceperiod {
    type: sum
    sql: ${TABLE}.GRACEPERIOD ;;
  }

  dimension: insitutionlocationid {
    type: string
    sql: ${TABLE}.INSITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: row_id {
    type: string
    sql: ${TABLE}.ROW_ID ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: enrollment_count {
    type: count
    drill_fields: []
  }
}
