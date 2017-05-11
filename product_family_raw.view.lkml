view: product_family_raw {
  sql_table_name: STG_APLIA.PRODUCT_FAMILY_RAW ;;

  measure: product_family_size {
    type: sum
    sql: ${TABLE}.PRODUCT_FAMILY_SIZE ;;
  }

  dimension: productfamily {
    type: string
    sql: ${TABLE}.PRODUCTFAMILY ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
