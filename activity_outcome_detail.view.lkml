view: activity_outcome_detail {
  sql_table_name: STG_MINDTAP.ACTIVITY_OUTCOME_DETAIL ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: activity_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ACTIVITY_ID ;;
  }

  dimension: activity_outcome_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ACTIVITY_OUTCOME_ID ;;
  }

  dimension: created_by {
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  dimension: created_date {
    type: string
    sql: ${TABLE}.CREATED_DATE ;;
  }

  dimension: is_auto_submitted {
    type: string
    sql: ${TABLE}.IS_AUTO_SUBMITTED ;;
  }

  dimension: is_deleted {
    type: string
    sql: ${TABLE}.IS_DELETED ;;
  }

  dimension: is_graded {
    type: string
    sql: ${TABLE}.IS_GRADED ;;
  }

  dimension: is_student_take {
    type: string
    sql: ${TABLE}.IS_STUDENT_TAKE ;;
  }

  dimension: last_autosubmit_date {
    type: string
    sql: ${TABLE}.LAST_AUTOSUBMIT_DATE ;;
  }

  dimension: last_modified_by {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_BY ;;
  }

  dimension: last_modified_date {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_DATE ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: points_earned {
    type: number
    sql: ${TABLE}.POINTS_EARNED ;;
  }

  dimension: points_possible {
    type: number
    sql: ${TABLE}.POINTS_POSSIBLE ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.SCORE ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: take_end_time {
    type: string
    sql: ${TABLE}.TAKE_END_TIME ;;
  }

  dimension: take_id {
    type: string
    sql: ${TABLE}.TAKE_ID ;;
  }

  dimension: take_number {
    type: string
    sql: ${TABLE}.TAKE_NUMBER ;;
  }

  dimension: take_start_time {
    type: string
    sql: ${TABLE}.TAKE_START_TIME ;;
  }

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      activity_outcome.id,
      activity.app_activity_id,
      user.id,
      user.fname,
      user.lname,
      user.source_name,
      user.username
    ]
  }
}
