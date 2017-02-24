view: dim_eventtype {
  label: "Learning Path Modifications"
  sql_table_name: DW_GA.DIM_EVENTTYPE ;;

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: eventtypename {
    label: "Action"
    type: string
    sql: ${TABLE}.EVENTTYPENAME ;;
  }
}
