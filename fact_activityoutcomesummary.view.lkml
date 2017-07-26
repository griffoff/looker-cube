view: fact_activityoutcomesummary {
  sql_table_name: DW_GA.FACT_ACTIVITYOUTCOMESUMMARY ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: activityid {
    type: number
    value_format_name: id
    sql: ${TABLE}.ACTIVITYID ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.ATTEMPTS ;;
  }

  dimension: course_weight {
    type: number
    sql: ${TABLE}.COURSE_WEIGHT ;;
  }

  dimension: courseid {
    type: number
    value_format_name: id
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: createddatekey {
    type: number
    sql: ${TABLE}.CREATEDDATEKEY ;;
  }

  dimension: dw_ldid {
    type: number
    value_format_name: id
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension: dw_ldts {
    type: string
    sql: ${TABLE}.DW_LDTS ;;
  }

  dimension: editedscore {
    type: number
    sql: ${TABLE}.EDITEDSCORE ;;
  }

  dimension: effectivescore {
    type: number
    sql: ${TABLE}.EFFECTIVESCORE ;;
  }

  dimension: filterflag {
    type: number
    sql: ${TABLE}.FILTERFLAG ;;
  }

  dimension: institutionid {
    type: number
    value_format_name: id
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: institutionlocationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
  }

  dimension: learningpathid {
    type: number
    value_format_name: id
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension_group: loaddate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
  }

  dimension: modifieddatekey {
    type: number
    sql: ${TABLE}.MODIFIEDDATEKEY ;;
  }

  dimension: partyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
  }

  dimension: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
  }

  dimension: productid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PRODUCTID ;;
  }

  dimension: rowid {
    type: number
    value_format_name: id
    sql: ${TABLE}.ROWID ;;
  }

  dimension: user_weight {
    type: number
    sql: ${TABLE}.USER_WEIGHT ;;
  }

  dimension: userid {
    type: number
    value_format_name: id
    sql: ${TABLE}.USERID ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
