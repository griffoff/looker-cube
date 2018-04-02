# view: role {
#   sql_table_name: STG_MINDTAP.ROLE ;;

#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.ID ;;
#   }

#   dimension: created_date {
#     type: string
#     sql: ${TABLE}.CREATED_DATE ;;
#   }

#   dimension: description {
#     type: string
#     sql: ${TABLE}.DESCRIPTION ;;
#   }

#   dimension: last_modified_date {
#     type: string
#     sql: ${TABLE}.LAST_MODIFIED_DATE ;;
#   }

#   dimension: ldts {
#     type: string
#     sql: ${TABLE}.LDTS ;;
#   }

#   dimension: name {
#     type: string
#     sql: ${TABLE}.NAME ;;
#   }

#   dimension: rsrc {
#     type: string
#     sql: ${TABLE}.RSRC ;;
#   }

#   dimension: version {
#     type: string
#     sql: ${TABLE}.VERSION ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [id, name, course_users.count, user_org_profile.count]
#   }
# }
