connection: "snowflake_dev"

include: "snowflake.*"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/core/common.lkml"

explore:warehouse_usage_detail  {
  hidden: yes
  join: database_storage {
    sql_on: ${warehouse_usage_detail.database_name} = ${database_storage.database_name}
      and ${warehouse_usage_detail.start_date} = ${database_storage.usage_date};;
      relationship: many_to_one
  }
}

explore: warehouse_usage {
  extends: [warehouse_usage_detail]
  join: warehouse_usage_total_time {
    sql_on: (${warehouse_usage.warehouse_name}, ${warehouse_usage.start_time_key}) = (${warehouse_usage_total_time.warehouse_name}, ${warehouse_usage_total_time.start_time_key})  ;;
    relationship: one_to_one
  }
  join: database_storage {
    sql_on: ${warehouse_usage.start_date} = ${database_storage.usage_date};;
    relationship: many_to_one
  }
  join: warehouse_usage_detail {
    sql_on: (${warehouse_usage.warehouse_name}, ${warehouse_usage.start_time_key}, ${database_storage.usage_date}) = (${warehouse_usage_detail.warehouse_name}, ${warehouse_usage_detail.start_time_key}, ${warehouse_usage_detail.start_date})  ;;
    relationship: one_to_many
  }

}
