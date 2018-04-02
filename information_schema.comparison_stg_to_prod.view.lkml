# view: schema_comparison {
#   view_label: "Schema"
#   derived_table: {
#     sql:
#     select
#         coalesce(stg.schema_name, prod.schema_name) as schema_name
#         ,case when stg.schema_name is not null then 1 end as schema_in_stg
#         ,case when prod.schema_name is not null then 1 end as schema_in_prod
#         ,case
#             when stg.schema_name is null then 'Missing from STG'
#             when prod.schema_name is null then 'Missing from PROD'
#             else 'Ok'
#             end as schema_status
#     from stg.information_schema.schemata stg
#     full join prod.information_schema.schemata prod
#     ;;
#     sql_trigger_value:
#         select
#             (select count(*) from stg.information_schema.schemata stg)
#           + (select count(*) from prod.information_schema.schemata prod)
#     ;;
#   }
#
#   set: details {
#     fields: [schema_name, schema_status]
#   }
#   dimension: schema_name {
#     primary_key: yes
#   }
#   dimension: schema_status {}
#   measure: schema_in_stg {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: schema_in_prod {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: count {
#     type: count
#     drill_fields: [details*]
#   }
# }
#
# view: table_comparison {
#   view_label: "Table/View"
#   derived_table: {
#     sql:
#     select
#         replace(replace('#s.#t'
#                             ,'#s', coalesce(prod.table_schema, stg.table_schema))
#                             ,'#t', coalesce(prod.table_name, stg.table_name))
#             as full_table_name
#         ,coalesce(stg.table_schema, prod.table_schema) as schema_name
#         ,coalesce(stg.table_name, prod.table_name) as table_name
#         ,coalesce(stg.table_type, prod.table_type) as table_type
#         ,case when stg.table_name is not null then 1 end as table_in_stg
#         ,case when prod.table_name is not null then 1 end as table_in_prod
#         ,case
#             when stg.table_name is null then 'Missing from STG'
#             when prod.table_name is null then 'Missing from PROD'
#             else 'Ok'
#             end as table_status
#     from stg.information_schema.tables stg
#     full join prod.information_schema.tables prod
# ;;
#     sql_trigger_value:
#         select
#         (select count(*) from stg.information_schema.tables stg)
#         + (select count(*) from prod.information_schema.tables prod)
#     ;;
#   }
#
#   dimension: full_table_name {
#     primary_key: yes
#     hidden: yes
#   }
#   dimension: schema_name {}
#   dimension: table_name {}
#   dimension: table_type {}
#   dimension: table_status {}
#
#   set: details {
#     fields: [schema_name, table_name, table_type, table_status]
#   }
#
#   measure: table_in_stg {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: table_in_prod {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: count {
#     type: count
#     drill_fields: [details*]
#   }
# }
#
# view: column_comparison {
#   view_label: "Column"
#    derived_table: {
#       sql:  select
#               replace(replace(replace('#s.#t.#c'
#                                 ,'#s', coalesce(prod.table_schema, stg.table_schema))
#                                 ,'#t', coalesce(prod.table_name, stg.table_name))
#                                 ,'#c', coalesce(prod.column_name, stg.column_name))
#                                 as full_column_name
#               ,coalesce(prod.table_schema, stg.table_schema) as schema_name
#               ,coalesce(prod.table_name, stg.table_name) as table_name
#               ,coalesce(prod.column_name, stg.column_name) as column_name
#               ,case when stg.column_name is not null then 1 end as column_in_stg
#               ,case when prod.column_name is not null then 1 end as column_in_prod
#               ,case
#                   when stg.table_catalog is null then 'Column Missing From STG'
#                   when prod.table_catalog is null then 'Column Missing From PROD'
#                   when stg.ordinal_position != prod.ordinal_position then 'Column Order Difference'
#                   when stg.data_type != prod.data_type then 'Data Type Difference'
#                   else 'Ok'
#               end as column_status
#           from stg.information_schema.columns stg
#           full join prod.information_schema.columns prod on (stg.table_schema, stg.table_name, stg.column_name) = (prod.table_schema, prod.table_name, prod.column_name)
#        ;;
#     sql_trigger_value:
#           select
#           (select count(*) from stg.information_schema.columns stg)
#           + (select count(*) from prod.information_schema.columns prod)
#     ;;
#    }
#
#   set: details {
#     fields: [schema_name, table_name, column_name, column_status]
#   }
#
#   dimension: full_column_name {
#     primary_key: yes
#     hidden: yes
#   }
#
#   dimension: schema_name {}
#   dimension: table_name {}
#   dimension: column_name {}
#   dimension: column_status {}
#
#   measure: column_in_stg {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: column_in_prod {
#     type: sum
#     drill_fields: [details*]
#   }
#   measure: count {
#     type: count
#     drill_fields: [details*]
#   }
#
#
# #
# #   # Define your dimensions and measures here, like this:
# #   dimension: user_id {
# #     description: "Unique ID for each user that has ordered"
# #     type: number
# #     sql: ${TABLE}.user_id ;;
# #   }
# #
# #   dimension: lifetime_orders {
# #     description: "The total number of orders for each user"
# #     type: number
# #     sql: ${TABLE}.lifetime_orders ;;
# #   }
# #
# #   dimension_group: most_recent_purchase {
# #     description: "The date when each user last ordered"
# #     type: time
# #     timeframes: [date, week, month, year]
# #     sql: ${TABLE}.most_recent_purchase_at ;;
# #   }
# #
# #   measure: total_lifetime_orders {
# #     description: "Use this for counting lifetime orders across many users"
# #     type: sum
# #     sql: ${lifetime_orders} ;;
# #   }
#  }
