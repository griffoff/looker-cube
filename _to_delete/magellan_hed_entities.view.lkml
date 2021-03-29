view: magellan_hed_entities {
  sql_table_name: LOOKER_WORKSHOP.MAGELLAN_HED_ENTITIES ;;

  dimension: entity_no {
    type: string
    sql: ${TABLE}.ENTITY_NO ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
