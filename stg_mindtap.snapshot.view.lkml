# view: snapshot {
#   sql_table_name: STG_MINDTAP.SNAPSHOT ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }
#
#   dimension: author {
#     type: string
#     sql: ${TABLE}.AUTHOR ;;
#   }
#
#   dimension: branding_discipline {
#     type: string
#     sql: ${TABLE}.BRANDING_DISCIPLINE ;;
#   }
#
#   dimension: cgi {
#     type: string
#     sql: ${TABLE}.CGI ;;
#   }
#
#   dimension: copyright {
#     type: string
#     sql: ${TABLE}.COPYRIGHT ;;
#   }
#
#   dimension: core_text_isbn {
#     type: string
#     sql: ${TABLE}.CORE_TEXT_ISBN ;;
#   }
#
#   dimension: created_by {
#     type: string
#     sql: ${TABLE}.CREATED_BY ;;
#   }
#
#   dimension: created_date {
#     type: date_time
#     sql: dateadd(millisecond, ${TABLE}.CREATED_DATE::int, 0::timestamp) ;;
#   }
#
#   dimension: credits {
#     type: string
#     sql: ${TABLE}.CREDITS ;;
#   }
#
#   dimension: default_path_id {
#     type: string
#     sql: ${TABLE}.DEFAULT_PATH_ID ;;
#   }
#
#   dimension: deployment_id {
#     type: string
#     sql: ${TABLE}.DEPLOYMENT_ID ;;
#   }
#
#   dimension: edition {
#     type: string
#     sql: ${TABLE}.EDITION ;;
#   }
#
#   dimension: integration_type {
#     type: string
#     sql: ${TABLE}.INTEGRATION_TYPE ;;
#   }
#
#   dimension: is_advanced_placement {
#     type: string
#     sql: ${TABLE}.IS_ADVANCED_PLACEMENT ;;
#   }
#
#   dimension: is_archived {
#     type: string
#     sql: ${TABLE}.IS_ARCHIVED ;;
#   }
#
#   dimension: is_deleted {
#     type: string
#     sql: ${TABLE}.IS_DELETED ;;
#   }
#
#   dimension: is_henley {
#     type: string
#     sql: ${TABLE}.IS_HENLEY ;;
#   }
#
#   dimension: is_locked {
#     type: string
#     sql: ${TABLE}.IS_LOCKED ;;
#   }
#
#   dimension: is_master {
#     type: string
#     sql: ${TABLE}.IS_MASTER ;;
#   }
#
#   dimension: is_reader_only {
#     type: string
#     sql: ${TABLE}.IS_READER_ONLY ;;
#   }
#
#   dimension: is_released {
#     type: string
#     sql: ${TABLE}.IS_RELEASED ;;
#   }
#
#   dimension: isbn {
#     type: string
#     sql: ${TABLE}.ISBN ;;
#   }
#
#   dimension: isbn_type {
#     type: string
#     sql: ${TABLE}.ISBN_TYPE ;;
#   }
#
#   dimension: last_annotation_copy_date {
#     type: string
#     sql: ${TABLE}.LAST_ANNOTATION_COPY_DATE ;;
#   }
#
#   dimension: last_lock_modified_by {
#     type: string
#     sql: ${TABLE}.LAST_LOCK_MODIFIED_BY ;;
#   }
#
#   dimension: last_modified_by {
#     type: string
#     sql: ${TABLE}.LAST_MODIFIED_BY ;;
#   }
#
#   dimension: last_modified_date {
#     type: date_time
#     sql: dateadd(millisecond, ${TABLE}.LAST_MODIFIED_DATE::int, 0::timestamp) ;;
#   }
#
#   dimension: ldts {
#     type: string
#     sql: ${TABLE}.LDTS ;;
#   }
#
#   dimension: lock_modified_date {
#     type: string
#     sql: ${TABLE}.LOCK_MODIFIED_DATE ;;
#   }
#
#   dimension: mtcopyright {
#     type: string
#     sql: ${TABLE}.MTCOPYRIGHT ;;
#   }
#
#   dimension: org_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.ORG_ID ;;
#   }
#
#   dimension: parent_id {
#     type: string
#     sql: ${TABLE}.PARENT_ID ;;
#   }
#
#   dimension: reader_level {
#     type: string
#     sql: ${TABLE}.READER_LEVEL ;;
#   }
#
#   dimension: root_node_id {
#     type: string
#     sql: ${TABLE}.ROOT_NODE_ID ;;
#   }
#
#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }
#
#   dimension: source_id {
#     type: string
#     sql: ${TABLE}.SOURCE_ID ;;
#   }
#
#   dimension: status {
#     type: string
#     sql: ${TABLE}.STATUS ;;
#   }
#
#   dimension: title {
#     type: string
#     sql: ${TABLE}.TITLE ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }
#
#   dimension: working_copy_id {
#     type: string
#     sql: ${TABLE}.WORKING_COPY_ID ;;
#   }
#
#   measure: count {
#     label: "# Snapshots"
#     type: count_distinct
#     sql: ${id} ;;
#     drill_fields: [detail*]
#   }
#
#   measure: master_count {
#     label: "# Masters"
#     type: count_distinct
#     sql: ${parent_id} ;;
#     drill_fields: [detail*]
#   }
#
#   # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       org.id,
#       org.name,
#       activity_outcome.count,
#       activity_outcome_summary.count,
#       course_users.count,
#       node.count,
#       org_snapshot.count,
#       student_outcome_summary.count
#     ]
#   }
# }
