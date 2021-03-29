view: dataprofiling {
  sql_table_name: ZPG.DATAPROFILING ;;

  dimension: columnname {
    type: string
    sql: ${TABLE}.COLUMNNAME ;;
  }

  dimension_group: ldts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LDTS ;;
  }

  dimension: profile {
    type: string
    sql: ${TABLE}.PROFILE ;;
  }

  dimension: tablename {
    type: string
    sql: ${TABLE}.TABLENAME ;;
  }

  dimension: testvalue {
    type: string
    sql: ${TABLE}.TESTVALUE ;;
  }

  measure: testvalue_number {
    type: average
    sql: ${TABLE}.TESTVALUE ;;
  }

  dimension: testvalue_count {
    type: number
    sql: ${TABLE}.TESTVALUE_ORDER ;;
  }

  dimension: testvalue_order {
    type: number
    sql: ${TABLE}.TESTVALUE_COUNT ;;
  }

  dimension: testvalue_percentoftotal {
    type: number
    sql: ${TABLE}.TESTVALUE_PERCENTOFTOTAL ;;
    value_format_name: percent_1
  }

  measure: count {
    type: count
    drill_fields: [tablename, columnname]
  }
}
