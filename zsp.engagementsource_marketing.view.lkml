view: engagementsource_marketing {
  sql_table_name: ZSP.ENGAGEMENTSOURCE_MARKETING ;;

  dimension: assessment {
    type: number
    sql: ${TABLE}.ASSESSMENT ;;
  }

  dimension: assignment_invocations {
    type: number
    sql: ${TABLE}.ASSIGNMENT_INVOCATIONS ;;
  }

  dimension: bookmarks {
    type: number
    sql: ${TABLE}.BOOKMARKS ;;
  }

  dimension: coursekey {
    type: string
    sql: ${TABLE}.COURSEKEY ;;
  }

  dimension: courseuri {
    type: string
    sql: ${TABLE}.COURSEURI ;;
  }

  dimension_group: first_login {
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
    sql: ${TABLE}.FIRST_LOGIN ;;
  }

  dimension: flashcards {
    type: number
    sql: ${TABLE}.FLASHCARDS ;;
  }

  dimension: highlights {
    type: number
    sql: ${TABLE}.HIGHLIGHTS ;;
  }

  dimension: isbn {
    type: string
    sql: ${TABLE}.ISBN ;;
  }

  dimension_group: last_login {
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
    sql: ${TABLE}.LAST_LOGIN ;;
  }

  dimension: logins {
    type: number
    sql: ${TABLE}.LOGINS ;;
  }

  measure : login_count {
    type:  sum
    sql: ${logins} ;;
  }

  dimension: media {
    type: number
    sql: ${TABLE}.MEDIA ;;
  }

  dimension: normalizationpartitioner {
    type: string
    sql: ${TABLE}.NORMALIZATIONPARTITIONER ;;
  }

  dimension: notes {
    type: number
    sql: ${TABLE}.NOTES ;;
  }

  dimension: others {
    type: number
    sql: ${TABLE}.OTHERS ;;
  }

  dimension: practice {
    type: number
    sql: ${TABLE}.PRACTICE ;;
  }

  dimension: reading {
    type: number
    sql: ${TABLE}.READING ;;
  }

  dimension: reading_activities {
    type: number
    sql: ${TABLE}.READING_ACTIVITIES ;;
  }

  dimension: searches {
    type: number
    sql: ${TABLE}.SEARCHES ;;
  }

  dimension: time_in_mindtap_avg {
    type: number
    sql: ${TABLE}.TIME_IN_MINDTAP_AVG ;;
  }

  dimension: time_in_mindtap_max {
    type: number
    sql: ${TABLE}.TIME_IN_MINDTAP_MAX ;;
  }

  dimension: time_in_mindtap_min {
    type: number
    sql: ${TABLE}.TIME_IN_MINDTAP_MIN ;;
  }

  dimension: time_in_mindtap_total {
    type: number
    sql: ${TABLE}.TIME_IN_MINDTAP_TOTAL ;;
  }

  dimension: total_activities {
    type: number
    sql: ${TABLE}.TOTAL_ACTIVITIES ;;
  }

  dimension: userguid {
    type: string
    sql: ${TABLE}.USERGUID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

}
