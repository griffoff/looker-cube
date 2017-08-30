view: item_properties {
  sql_table_name: LOOKER_SCRATCH.ITEM_PROPERTIES ;;

  dimension: id {
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: activity_activityitemuri {
    type: string
    sql: ${TABLE}.ACTIVITY_ACTIVITYITEMURI ;;
    primary_key: yes
    hidden: yes
  }

  dimension: container_type {
    type: string
    sql: ${TABLE}.CONTAINER_TYPE ;;
  }

  dimension: csfi_category {
    type: string
    sql: ${TABLE}.CSFI_CATEGORY ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
