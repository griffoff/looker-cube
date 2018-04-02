# view: student_outcome_summary {
#   sql_table_name: STG_MINDTAP.STUDENT_OUTCOME_SUMMARY ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }
#
#   dimension: category_score {
#     type: number
#     sql: ${TABLE}.CATEGORY_SCORE ;;
#   }
#
#   dimension: class_average {
#     type: number
#     sql: ${TABLE}.CLASS_AVERAGE ;;
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
#   dimension: last_computed_score_time {
#     type: string
#     sql: ${TABLE}.LAST_COMPUTED_SCORE_TIME ;;
#   }
#
#   dimension: last_modified_by {
#     type: string
#     sql: ${TABLE}.LAST_MODIFIED_BY ;;
#   }
#
#   dimension: last_modified_date {
#     type: string
#     sql: ${TABLE}.LAST_MODIFIED_DATE ;;
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
#       snapshot.id,
#       user.id,
#       user.fname,
#       user.lname,
#       user.source_name,
#       user.username
#     ]
#   }
# }
