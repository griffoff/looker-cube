view: dim_productplatform {
  label: "Product Platform"
  sql_table_name: DW_GA.DIM_PRODUCTPLATFORM ;;

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: is_platform {
    type: string
    sql: ${TABLE}.IS_PLATFORM ;;
    hidden: yes
  }

  dimension: productplatform {
    label: "Platfom name"
    type: string
    sql: ${TABLE}.PRODUCTPLATFORM ;;
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
    primary_key: yes
  }

  measure: count {
    label: "No. of product platforms"
    type: count
    drill_fields: []
  }
}
