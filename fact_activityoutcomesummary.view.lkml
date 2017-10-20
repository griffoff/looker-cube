view: fact_activityoutcomesummary {
  view_label: "Learning Path - Activity Final Outcomes"
  sql_table_name: DW_GA.FACT_ACTIVITYOUTCOMESUMMARY ;;

  dimension: editedscore {
    type: number
    sql: ${TABLE}.EDITEDSCORE ;;
  }

  dimension: effectivescore {
    type: number
    sql: ${TABLE}.EFFECTIVESCORE ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.ATTEMPTS ;;
  }

  dimension: course_weight {
    type: number
    sql: ${TABLE}.COURSE_WEIGHT ;;
  }

  dimension: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
  }

  dimension: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
  }

  dimension: user_weight {
    type: number
    sql: ${TABLE}.USER_WEIGHT ;;
  }

  measure: score_to_final_score_correlation {
    label: "Activity Score to MindTap overall score correlation"
    type: number
    sql: CORR(${user_final_scores.final_score}, ${effectivescore}) ;;
    value_format_name: decimal_3
  }

  dimension: id {
    type: number
    sql: ${TABLE}.ID ;;
    hidden: yes
  }

  dimension: activityid {
    type: number
    value_format_name: id
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: courseid {
    type: number
    value_format_name: id
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: createddatekey {
    type: number
    sql: ${TABLE}.CREATEDDATEKEY ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: number
    value_format_name: id
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension: dw_ldts {
    type: string
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: filterflag {
    type: number
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: institutionid {
    type: number
    value_format_name: id
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: institutionlocationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: number
    value_format_name: id
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: modifieddatekey {
    type: number
    sql: ${TABLE}.MODIFIEDDATEKEY ;;
    hidden: yes
  }

  dimension: partyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: rowid {
    type: number
    value_format_name: id
    sql: ${TABLE}.ROWID ;;
    hidden: yes
  }

  dimension: userid {
    type: number
    value_format_name: id
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
