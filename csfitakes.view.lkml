view: csfitakes {
  label: "CSFI Surveys"
  sql_table_name: ZPG.CSFITAKES ;;

  dimension: activityitemuri {
    type: string
    sql: ${TABLE}.ACTIVITYITEMURI ;;
  }

  dimension: answer {
    type: number
    sql: ${TABLE}.ANSWER ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: q {
    type: string
    sql: ${TABLE}.Q ;;
  }

  dimension: qno {
    type: number
    sql: ${TABLE}.QNO ;;
    value_format: "0"
  }

  dimension: qtext {
    type: string
    sql: ${TABLE}.QTEXT ;;
  }

  measure: take_count {
    label: "# of takes"
    type: count_distinct
    sql: ${TABLE}.TAKE_OID ;;
  }

  dimension_group: take_submissiondate {
    label: "Take submission date"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.TAKE_SUBMISSIONDATE ;;
  }

  dimension: testdesc {
    label: "test description"
    type: string
    sql: ${TABLE}.TESTDESC ;;
  }

  measure: user_count {
    label: "# of users"
    type: count_distinct
    sql: ${TABLE}.USER_OID ;;
  }

  measure: user_percent {
    label: "% of users"
    type:  percent_of_total
    sql: ${user_count} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
