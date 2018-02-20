view: dim_eventaction {
  label: "CLA Events"
  sql_table_name: DW_GA.DIM_EVENTACTION ;;

  dimension: dw_ldid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.DW_LDID ;;
  }

  dimension: dw_ldts {
    type: string
    hidden: yes
    sql: ${TABLE}.DW_LDTS ;;
  }

  dimension: eventactionid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.EVENTACTIONID ;;
  }

  dimension: eventactionname {
    label: "Event Action Name"
    description: "distinguish between Start & Stop Events "
    type: string
    sql: ${TABLE}.EVENTACTIONNAME ;;
  }

  measure: count {
    type: count
    drill_fields: [eventactionname]
  }
}
