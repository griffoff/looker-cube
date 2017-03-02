view: fact_activation {
  label: "Activations"
  sql_table_name: DW_GA.FACT_ACTIVATION ;;

  dimension: activationcode {
    type: string
    sql: ${TABLE}.ACTIVATIONCODE ;;
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
  }

  measure: avg_noofactivations {
    label: "Avg. activations"
    type: average
    sql: ${noofactivations_base} ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
