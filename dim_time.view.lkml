view: dim_time {
  label: "Time of Day"
  sql_table_name: DW_GA.DIM_TIME ;;

  dimension: ampm {
    type: string
    sql: ${TABLE}.AMPM ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}.HOUR ;;
    order_by_field: hour24
  }

  dimension: hour24 {
    type: number
    sql: ${TABLE}.HOUR24 ;;
  }

  dimension: minute {
    type: number
    sql: ${TABLE}.MINUTE ;;
  }

  dimension_group: time {
    type: time
    timeframes: [hour_of_day, minute, raw]
    sql: ${TABLE}.TIME ;;
    hidden: yes
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
    primary_key: yes
  }
}

#- measure: count
#  type: count
#  drill_fields: []
