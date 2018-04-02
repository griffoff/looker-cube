# view: app_activity {
#   sql_table_name: STG_MINDTAP.APP_ACTIVITY ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }
#
#   dimension: add_action_id {
#     type: string
#     sql: ${TABLE}.ADD_ACTION_ID ;;
#   }
#
#   dimension: app_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.APP_ID ;;
#   }
#
#   dimension: category {
#     type: string
#     sql: ${TABLE}.CATEGORY ;;
#   }
#
#   dimension: configure_action_id {
#     type: string
#     sql: ${TABLE}.CONFIGURE_ACTION_ID ;;
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
#   dimension: description_editable {
#     type: string
#     sql: ${TABLE}.DESCRIPTION_EDITABLE ;;
#   }
#
#   dimension: display_name {
#     type: string
#     sql: ${TABLE}.DISPLAY_NAME ;;
#   }
#
#   dimension: end_date {
#     type: string
#     sql: ${TABLE}.END_DATE ;;
#   }
#
#   dimension: end_date_with_gating {
#     type: string
#     sql: ${TABLE}.END_DATE_WITH_GATING ;;
#   }
#
#   dimension: grade_action_id {
#     type: string
#     sql: ${TABLE}.GRADE_ACTION_ID ;;
#   }
#
#   dimension: icon {
#     type: string
#     sql: ${TABLE}.ICON ;;
#   }
#
#   dimension: ignore_grades_after_end_date {
#     type: string
#     sql: ${TABLE}.IGNORE_GRADES_AFTER_END_DATE ;;
#   }
#
#   dimension: interaction {
#     type: string
#     sql: ${TABLE}.INTERACTION ;;
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
#   dimension: option_editable {
#     type: string
#     sql: ${TABLE}.OPTION_EDITABLE ;;
#   }
#
#   dimension: placement {
#     type: string
#     sql: ${TABLE}.PLACEMENT ;;
#   }
#
#   dimension: post_create_action {
#     type: string
#     sql: ${TABLE}.POST_CREATE_ACTION ;;
#   }
#
#   dimension: review_in_progress {
#     type: string
#     sql: ${TABLE}.REVIEW_IN_PROGRESS ;;
#   }
#
#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }
#
#   dimension: start_attempt_on_launch {
#     type: string
#     sql: ${TABLE}.START_ATTEMPT_ON_LAUNCH ;;
#   }
#
#   dimension: start_date {
#     type: string
#     sql: ${TABLE}.START_DATE ;;
#   }
#
#   dimension: start_date_with_gating {
#     type: string
#     sql: ${TABLE}.START_DATE_WITH_GATING ;;
#   }
#
#   dimension: supports_annotations {
#     type: string
#     sql: ${TABLE}.SUPPORTS_ANNOTATIONS ;;
#   }
#
#   dimension: supports_copy {
#     type: string
#     sql: ${TABLE}.SUPPORTS_COPY ;;
#   }
#
#   dimension: supports_ctxmenu {
#     type: string
#     sql: ${TABLE}.SUPPORTS_CTXMENU ;;
#   }
#
#   dimension: supports_mobile {
#     type: string
#     sql: ${TABLE}.SUPPORTS_MOBILE ;;
#   }
#
#   dimension: title_editable {
#     type: string
#     sql: ${TABLE}.TITLE_EDITABLE ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }
#
#   dimension: view_action_id {
#     type: string
#     sql: ${TABLE}.VIEW_ACTION_ID ;;
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
#       name,
#       display_name,
#       app.id,
#       app.name,
#       app.display_name
#     ]
#   }
# }
