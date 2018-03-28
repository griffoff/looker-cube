connection: "snowflake_dev"

include: "snowflake.*"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: warehouse_usage {}
