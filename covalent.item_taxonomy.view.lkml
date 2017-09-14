view: item_taxonomy {
  sql_table_name: LOOKER_SCRATCH.ITEM_TAXONOMY ;;

  dimension: activity_activityitemuri {
    type: string
    sql: ${TABLE}.ACTIVITY_ACTIVITYITEMURI ;;
    hidden: yes
  }

  dimension: taxonomy {
    type: string
    sql: ${TABLE}.TAXONOMY ;;
  }

  dimension: taxonomy_value {
    type: string
    sql: ${TABLE}.TAXONOMY_VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
