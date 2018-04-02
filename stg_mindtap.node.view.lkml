# view: node {
#   sql_table_name: STG_MINDTAP.NODE ;;
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
#   dimension: description {
#     type: string
#     sql: ${TABLE}.DESCRIPTION ;;
#   }
#
#   dimension: display_order {
#     type: string
#     sql: ${TABLE}.DISPLAY_ORDER ;;
#   }
#
#   dimension: end_date {
#     type: string
#     sql: ${TABLE}.END_DATE ;;
#   }
#
#   dimension: is_student_visible {
#     type: string
#     sql: ${TABLE}.IS_STUDENT_VISIBLE ;;
#   }
#
#   dimension: is_visible {
#     type: string
#     sql: ${TABLE}.IS_VISIBLE ;;
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
#   dimension: name {
#     type: string
#     sql: ${TABLE}.NAME ;;
#   }
#
#   dimension: node_type {
#     type: string
#     sql: ${TABLE}.NODE_TYPE ;;
#   }
#
#   dimension: origin_id {
#     type: string
#     sql: ${TABLE}.ORIGIN_ID ;;
#   }
#
#   dimension: parent_id {
#     type: string
#     sql: ${TABLE}.PARENT_ID ;;
#   }
#
#   dimension: prev_end_date {
#     type: string
#     sql: ${TABLE}.PREV_END_DATE ;;
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
#   dimension: start_date {
#     type: string
#     sql: ${TABLE}.START_DATE ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [id, name, snapshot.id]
#   }
# }
