# view: app {
#   sql_table_name: STG_MINDTAP.APP ;;
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }
#
#   dimension: annotation_info {
#     type: string
#     sql: ${TABLE}.ANNOTATION_INFO ;;
#   }
#
#   dimension: app_version {
#     type: string
#     sql: ${TABLE}.APP_VERSION ;;
#   }
#
#   dimension: auth_scheme {
#     type: string
#     sql: ${TABLE}.AUTH_SCHEME ;;
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
#   dimension: creator {
#     type: string
#     sql: ${TABLE}.CREATOR ;;
#   }
#
#   dimension: deploy_mode {
#     type: string
#     sql: ${TABLE}.DEPLOY_MODE ;;
#   }
#
#   dimension: display_name {
#     type: string
#     sql: ${TABLE}.DISPLAY_NAME ;;
#   }
#
#   dimension: event_notification_url {
#     type: string
#     sql: ${TABLE}.EVENT_NOTIFICATION_URL ;;
#   }
#
#   dimension: help_uri {
#     type: string
#     sql: ${TABLE}.HELP_URI ;;
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
#   dimension: lti_compliant {
#     type: string
#     sql: ${TABLE}.LTI_COMPLIANT ;;
#   }
#
#   dimension: lti_consumer_key {
#     type: string
#     sql: ${TABLE}.LTI_CONSUMER_KEY ;;
#   }
#
#   dimension: lti_mode {
#     type: string
#     sql: ${TABLE}.LTI_MODE ;;
#   }
#
#   dimension: name {
#     type: string
#     sql: ${TABLE}.NAME ;;
#   }
#
#   dimension: privacy_setting {
#     type: string
#     sql: ${TABLE}.PRIVACY_SETTING ;;
#   }
#
#   dimension: provision_type {
#     type: string
#     sql: ${TABLE}.PROVISION_TYPE ;;
#   }
#
#   dimension: root_uri {
#     type: string
#     sql: ${TABLE}.ROOT_URI ;;
#   }
#
#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }
#
#   dimension: secure_launch {
#     type: string
#     sql: ${TABLE}.SECURE_LAUNCH ;;
#   }
#
#   dimension: services_on_ssl {
#     type: string
#     sql: ${TABLE}.SERVICES_ON_SSL ;;
#   }
#
#   dimension: shared_secret {
#     type: string
#     sql: ${TABLE}.SHARED_SECRET ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }
#
#   measure: count {
#     label: "# Apps"
#     type: count_distinct
#     drill_fields: [detail*]
#   }
#
#   # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       name,
#       display_name,
#       activity.count,
#       app_action.count,
#       app_activities.count,
#       app_activity.count,
#       tmp_mt_nb_activity_20170503010500.count
#     ]
#   }
# }
