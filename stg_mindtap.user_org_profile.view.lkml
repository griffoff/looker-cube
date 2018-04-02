# view: user_org_profile {
#   sql_table_name: STG_MINDTAP.USER_ORG_PROFILE ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
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
#   dimension: dropped_by {
#     type: string
#     sql: ${TABLE}.DROPPED_BY ;;
#   }
#
#   dimension: dropped_date {
#     type: string
#     sql: ${TABLE}.DROPPED_DATE ;;
#   }
#
#   dimension: is_dropped {
#     type: string
#     sql: ${TABLE}.IS_DROPPED ;;
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
#   dimension: ldts {
#     type: string
#     sql: ${TABLE}.LDTS ;;
#   }
#
#   dimension: org_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.ORG_ID ;;
#   }
#
#   dimension: role_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.ROLE_ID ;;
#   }
#
#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }
#
#   dimension: student_id {
#     type: string
#     sql: ${TABLE}.STUDENT_ID ;;
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
#       org.id,
#       org.name,
#       role.id,
#       role.name,
#       user.id,
#       user.fname,
#       user.lname,
#       user.source_name,
#       user.username
#     ]
#   }
# }
