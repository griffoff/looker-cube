include: "mankiw_questions"

view: soa_questions {
  extends: [mankiw_questions]
  sql_table_name: zpg.soa_questions ;;
  label: "SOA Questions"

  dimension: container_type {
    type: string
    sql: ${TABLE}.containerType ;;
  }

  dimension: activity_type {
    type: string
    sql: ${TABLE}.activity_Type ;;
  }

}
