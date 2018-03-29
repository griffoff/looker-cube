# include: "snowflake_analysis.model.lkml"
view: warehouse_usage_total_time {
    view_label: "Warehouse Usage"
    derived_table: {
      explore_source: warehouse_usage_detail {
        derived_column: pk {sql:warehouse_name||start_time_key;;}
        column: warehouse_name {}
        column: start_time_key {}
        column: total_elapsed_time {}
        column: total_elapsed_time_compute_only {}
        column: count {}
      }
    }
    dimension: pk {hidden:yes primary_key:yes}
    dimension: warehouse_name {hidden:yes}
    dimension: start_time_key {hidden:yes}
    measure: total_elapsed_time {
      type: sum
      value_format_name: duration_hms
    }
  measure: total_elapsed_time_compute_only {
    type: sum
    value_format_name: duration_hms
  }
    dimension: count {
      type: number
    }
}
