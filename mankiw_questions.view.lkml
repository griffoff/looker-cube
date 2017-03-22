view: mankiw_questions {
  label: "MANKIW Questions"
  sql_table_name: ZPG.MANKIW_QUESTIONS ;;

  set: take_details {
    fields: [take_oid, user_oid]
  }

  dimension: activityitemuri {
    type: string
    sql: ${TABLE}.ACTIVITYITEMURI ;;
  }

  dimension: activityuri {
    type: string
    sql: ${TABLE}.ACTIVITYURI ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: externalid {
    type: string
    sql: ${TABLE}.EXTERNALID ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: markedtaken {
    type: yesno
    sql: ${TABLE}.MARKEDTAKEN ;;
  }

  measure: taken {
    type: sum
    sql: CASE WHEN ${markedtaken} THEN 1 END ;;
  }

  dimension: normalscore {
    hidden: yes
    type: number
    sql: IFF(${TABLE}.SCOREREQUIRED OR ${TABLE}.MARKEDTAKEN, ${TABLE}.NORMALSCORE, NULL) ;;
  }

  dimension: normalscore_bucket {
    label: "Score Bins"
    group_label: "Score"
    type: tier
    style: interval
    tiers: [0, 0.3, 0.5, 0.7, 0.9]
  }

  measure: normalscore_avg {
    label: "Avg Score"
    group_label: "Score"
    type: average
    sql: ${normalscore} ;;
    value_format_name: percent_1
    drill_fields: [coursekey, activityitemuri, label, normalscore, take_oid,take_submissiondate_date, user_oid]
  }

  measure: normalscore_min {
    label: "Min Score"
    group_label: "Score"
    type: min
    sql: ${normalscore} ;;
    value_format_name: percent_1
  }

  measure: normalscore_max {
    label: "Max Score"
    group_label: "Score"
    type: max
    sql: ${normalscore} ;;
    value_format_name: percent_1
  }

  dimension: possiblescore {
    type: number
    sql: ${TABLE}.POSSIBLESCORE ;;
  }

  dimension: score {
    hidden: yes
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension: scorerequired {
    type: yesno
    sql: ${TABLE}.SCOREREQUIRED ;;
  }

  measure: required {
    type: sum
    sql: CASE WHEN ${scorerequired} THEN 1 END ;;
  }

  dimension: take_oid {
    type: string
    sql: ${TABLE}.TAKE_OID ;;
    link: {
        label:"View in Analytics Diagnostic Tool"
        url: "https://analytics-tools.cengage.info/diagnostictool/#/activity-take/view/production/id/{{value}}"
      }
  }

  dimension_group: take_submissiondate {
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

  dimension: timespent {
    type: number
    sql: ${TABLE}.TIMESPENT ;;
  }

  dimension: timespent_bin {
    type: tier
    tiers: [0, 500, 1000, 2000, 5000, 10000]
    style: integer
    sql: ${TABLE}.TIMESPENT ;;
  }

  dimension: user_oid {
    type: string
    sql: ${TABLE}.USER_OID ;;
  }

  measure: user_count {
      label: "# users"
      type: count_distinct
      sql:  ${user_oid} ;;
  }

  measure: item_count {
    label: "# activities"
    type: count_distinct
    sql:  ${activityuri} ;;
  }

  measure: activity_count {
    label: "# items"
    type: count_distinct
    sql:  ${activityitemuri} ;;
  }

  measure: take_count {
    label: "# takes"
    type: count_distinct
    sql:  ${take_oid} ;;
    drill_fields: [take_details*]
  }

  measure:  take_count_percent {
    label: "% takes"
    type:  percent_of_total
    sql: ${take_count} ;;
  }

  measure: course_count {
    label: "# courses"
    type: count_distinct
    sql: ${coursekey} ;;
  }

  measure: count {
    type: count
    drill_fields: [coursekey, activityitemuri, label, normalscore, take_oid,take_submissiondate_date, user_oid]
  }
}