# view: load_history {
#   derived_table: {
#     sql:
#       select
#         'PROD' as table_catalog
#         , *
#         , row_number() over (partition by schema_name, table_name order by last_load_time desc) as latest
#       from INFORMATION_SCHEMA.LOAD_HISTORY;;
#     }
# #   derived_table: {
# #     sql:
# #       select 'PROD' as table_catalog, * from prod.INFORMATION_SCHEMA.LOAD_HISTORY
# #       union all
# #       select 'STG' as table_catalog, * from stg.INFORMATION_SCHEMA.LOAD_HISTORY
# #       union all
# #       select 'DEV' as table_catalog, * from dev.INFORMATION_SCHEMA.LOAD_HISTORY ;;
# #
# #       sql_trigger_value:
# #         (select count(*) from prod.information_schema.load_history)
# #         +(select count(*) from stg.information_schema.load_history)
# #         +(select count(*) from dev.information_schema.load_history);;
# #   }
#
#   dimension: latest {
#     type:  number
#     description: "reverse version number, filter to value '1' to include only the latest load"
#   }
#
#   dimension: table_catalog {}
#
#   measure: error_count {
#     type: sum
#     sql: ${TABLE}.ERROR_COUNT ;;
#   }
#
#   measure: error_limit {
#     type: sum
#     sql: ${TABLE}.ERROR_LIMIT ;;
#   }
#
#   dimension: file_name {
#     type: string
#     sql: ${TABLE}.FILE_NAME ;;
#   }
#
#   dimension: first_error_character_position {
#     type: number
#     sql: ${TABLE}.FIRST_ERROR_CHARACTER_POSITION ;;
#   }
#
#   dimension: first_error_col_name {
#     type: string
#     sql: ${TABLE}.FIRST_ERROR_COL_NAME ;;
#   }
#
#   dimension: first_error_line_number {
#     type: number
#     sql: ${TABLE}.FIRST_ERROR_LINE_NUMBER ;;
#   }
#
#   dimension: first_error_message {
#     type: string
#     sql: ${TABLE}.FIRST_ERROR_MESSAGE ;;
#   }
#
#   dimension_group: last_load {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.LAST_LOAD_TIME ;;
#   }
#
#   measure: row_count {
#     type: sum
#     sql: ${TABLE}.ROW_COUNT ;;
#   }
#
#   measure: row_parsed {
#     type: sum
#     sql: ${TABLE}.ROW_PARSED ;;
#   }
#
#   dimension: schema_name {
#     type: string
#     sql: ${TABLE}.SCHEMA_NAME ;;
#   }
#
#   dimension: status {
#     type: string
#     sql: ${TABLE}.STATUS ;;
#   }
#
#   dimension: table_name {
#     type: string
#     sql: ${TABLE}.TABLE_NAME ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [schema_name, file_name, table_name, first_error_col_name]
#   }
# }
