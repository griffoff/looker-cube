view: dim_cla_item {
  sql_table_name: DW_GA.DIM_CLA_ITEM ;;

  dimension: activitycgi {
    type: string
    hidden: yes
    sql: ${TABLE}.ACTIVITYCGI ;;
  }

  dimension: cla_itemid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.CLA_ITEMID ;;
  }

  dimension: cla_itemname {
    label: "Item Name"
    description: "Too be added"
    type: string
    sql: ${TABLE}.CLA_ITEMNAME ;;
  }

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

  dimension: learningpathid {
    type: number
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension: subactivitycgi {
    type: string
    hidden: yes
    sql: ${TABLE}.SUBACTIVITYCGI ;;
  }

  dimension: subactivitytype {
    type: string
    sql: ${TABLE}.SUBACTIVITYTYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [cla_itemname]
  }
}
