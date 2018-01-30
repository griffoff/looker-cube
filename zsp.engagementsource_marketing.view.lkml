view: engagementsource_marketing {
  sql_table_name: ZSP.ENGAGEMENTSOURCE_MARKETING ;;

  dimension: assessment {
    type: number
    sql: ${TABLE}.ASSESSMENT ;;
  }
  measure: Assessment_Count {
    type: sum
    sql: ${assessment} ;;
  }


  dimension: assignment_invocations {
    type: number
    sql: ${TABLE}.ASSIGNMENT_INVOCATIONS ;;
  }
  measure:  Assignment_Invocations_Count{
    type: sum
    sql: ${assignment_invocations} ;;
  }


  dimension: bookmarks {
    type: number
    sql: ${TABLE}.BOOKMARKS ;;
  }
  measure: Bookmarks_Count {
    type: sum
    sql:  ${bookmarks} ;;
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
  measure: Flashcards_Count {
    type: sum
    sql:  ${flashcards} ;;
  }


  dimension: highlights {
    type: number
    sql: ${TABLE}.HIGHLIGHTS ;;
  }
  measure: Highlights_Count {
    type: sum
    sql:  ${highlights} ;;
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
  measure : Media_Count {
    type:  sum
    sql: ${media} ;;
  }

  dimension: normalizationpartitioner {
    type: string
    sql: ${TABLE}.NORMALIZATIONPARTITIONER ;;
  }

  dimension: notes {
    type: number
    sql: ${TABLE}.NOTES ;;
  }
  measure : Notes_Count {
    type:  sum
    sql: ${notes} ;;
  }



  dimension: others {
    type: number
    sql: ${TABLE}.OTHERS ;;
  }
  measure: OtherActivities_Count {
    type: sum
    sql: ${others} ;;
  }

  dimension: practice {
    type: number
    sql: ${TABLE}.PRACTICE ;;
  }
  measure: Practise_Counts {
    type: sum
    sql: ${practice} ;;
  }


  dimension: reading {
    type: number
    sql: ${TABLE}.READING ;;
  }
  measure: Reading_Counts {
    type: sum
    sql: ${reading} ;;
  }


  dimension: reading_activities {
    type: number
    sql: ${TABLE}.READING_ACTIVITIES ;;
  }
  measure: Reading_Activities_Count {
    type: sum
    sql: ${reading_activities} ;;
  }

  dimension: searches {
    type: number
    sql: ${TABLE}.SEARCHES ;;
  }
  measure: Searches_Count {
    type: sum
    sql: ${searches} ;;
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
  measure: Total_Time_In_MindTap {
    type: sum
    sql: ${time_in_mindtap_total} ;;
  }


  dimension: total_activities {
    type: number
    sql: ${TABLE}.TOTAL_ACTIVITIES ;;
  }
  measure: Total_Activities_Count {
    type: sum
    sql:  ${total_activities} ;;

  }

  dimension: userguid {
    type: string
    sql: ${TABLE}.USERGUID ;;
  }
  measure: Student_Count {
    type: sum
    sql: ${userguid} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

}
