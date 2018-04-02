# view: activity_outcome {
#   sql_table_name: STG_MINDTAP.ACTIVITY_OUTCOME ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }
#
#   dimension: activity_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.ACTIVITY_ID ;;
#   }
#
#   dimension: alert {
#     type: string
#     sql: ${TABLE}.ALERT ;;
#   }
#
#   dimension: attempts {
#     type: string
#     sql: ${TABLE}.ATTEMPTS ;;
#   }
#
#   dimension: created_by {
#     type: string
#     sql: ${TABLE}.CREATED_BY ;;
#   }
#
#   dimension: created_date {
#     type: string
#     sql: ${TABLE}.CREATED_DATE ;;
#   }
#
#   dimension: current_take_id {
#     type: string
#     sql: ${TABLE}.CURRENT_TAKE_ID ;;
#   }
#
#   dimension: edited_score {
#     type: number
#     sql: ${TABLE}.EDITED_SCORE ;;
#   }
#
#   dimension: effective_score {
#     type: number
#     sql: ${TABLE}.EFFECTIVE_SCORE ;;
#   }
#
#   dimension: is_dropped {
#     type: string
#     sql: ${TABLE}.IS_DROPPED ;;
#   }
#
#   dimension: is_student {
#     type: string
#     sql: ${TABLE}.IS_STUDENT ;;
#   }
#
#   dimension: last_modified_by {
#     type: string
#     sql: ${TABLE}.LAST_MODIFIED_BY ;;
#   }
#
#   dimension_group: last_modified_date {
#     type: time
#     timeframes: [year, day_of_week, week_of_year]
#     sql: dateadd(millisecond, ${TABLE}.LAST_MODIFIED_DATE::int, 0::timestamp) ;;
#   }
#
#   dimension: last_score_modified_time {
#     type: string
#     sql: ${TABLE}.LAST_SCORE_MODIFIED_TIME ;;
#   }
#
#   dimension: ldts {
#     type: string
#     sql: ${TABLE}.LDTS ;;
#   }
#
#   dimension: points_earned {
#     type: number
#     sql: ${TABLE}.POINTS_EARNED ;;
#   }
#
#   dimension: points_possible {
#     type: number
#     sql: ${TABLE}.POINTS_POSSIBLE ;;
#   }
#
#   dimension: remaining_takes {
#     type: string
#     sql: ${TABLE}.REMAINING_TAKES ;;
#   }
#
#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }
#
#   dimension: snapshot_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.SNAPSHOT_ID ;;
#   }
#
#   dimension: user_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.USER_ID ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
#   # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       activity.app_activity_id,
#       snapshot.id,
#       user.id,
#       user.fname,
#       user.lname,
#       user.source_name,
#       user.username,
#       activity_outcome_detail.count
#     ]
#   }
# }
