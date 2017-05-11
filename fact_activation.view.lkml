view: fact_activation {
  view_label: "Activations"
  sql_table_name: ZPG_ACTIVATIONS.DW_GA.FACT_ACTIVATION ;;

  set: coursedetails {
    fields: [dim_course.coursekey, activationcode]
  }

  dimension: activationcode {
    type: string
    sql: ${TABLE}.ACTIVATIONCODE ;;
  }

  dimension: activationcodeuser {
    type: string
    sql: ${TABLE}.ACTIVATIONCODE_USER ;;
    hidden: yes
    primary_key: yes
  }

  dimension: activationdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVATIONDATEKEY ;;
  }

  dimension: activationtypeid {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVATIONTYPEID ;;
  }

  dimension: courseid {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: daysbeforecourseend {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
  }

  dimension: daysfromcoursestart {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
  }

  dimension: dw_ldid {
    hidden: yes
    type: string
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension_group: dw_ldts {
    hidden: yes
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
  }

  dimension: institutionid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: institutionlocationid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
  }

  dimension_group: loaddate {
    hidden: yes
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
  }

  dimension: noofactivations_base {
    type: number
    sql: ${TABLE}.NOOFACTIVATIONS ;;
    hidden: yes
  }

  measure: total_noofactivations {
    label: "Total activations"
    type: sum
    sql: ${noofactivations_base} ;;
    drill_fields: [coursedetails*]
  }

  measure: avg_noofactivations {
    label: "Avg. activations"
    type: average
    sql: ${noofactivations_base} ;;
    drill_fields: [coursedetails*]
  }

  dimension: partyid {
    hidden: yes
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: productid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTID ;;
  }

  dimension: productplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
  }

  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.USERID ;;
  }

  dimension: activationfilterid {
    hidden: yes
    type: number
    sql: ${TABLE}.ACTIVATIONFILTERID ;;
  }

  dimension: activationregionid {
    hidden: yes
    type: number
    sql: ${TABLE}.ACTIVATIONREGIONID ;;
  }

  measure: user_count {
    label: "# Users Activated"
    type: count_distinct
    sql:${userid} ;;
  }

  measure: user_percent_of_total {
    label: "# Users % of total"
    type: percent_of_total
    sql: ${user_count} ;;
  }

  measure: institution_count {
    label: "# Institutions with activations"
    type: count_distinct
    sql: case when ${TABLE}.NOOFACTIVATIONS > 0 then ${dim_institution.institutionid} end ;;
  }

  measure: course_count {
    label: "# Courses with activations"
    type: count_distinct
    sql: ${courseid} ;;
  }
}
