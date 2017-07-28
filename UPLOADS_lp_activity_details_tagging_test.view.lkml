view: UPLOADS_lp_activity_details_tagging_test {
  view_label: "Learning Path - Activity Tagging TEST"
  sql_table_name: ZJB.LP_ACTIVITY_DETAILS_TAGGING_TEST ;;

  dimension: activity_cluster {
    type: string
    sql: ${TABLE}.ACTIVITY_CLUSTER ;;
  }

  dimension: activity_sub_cluster {
    type: string
    sql: ${TABLE}.ACTIVITY_SUB_CLUSTER ;;
  }

  dimension: activity_title {
    type: string
    sql: ${TABLE}.ACTIVITY_TITLE ;;
  }

  dimension: activty_subtype {
    type: string
    sql: ${TABLE}.ACTIVTY_SUBTYPE ;;
  }

  dimension: activty_type {
    type: string
    sql: ${TABLE}.ACTIVTY_TYPE ;;
  }

  dimension: chapter {
    type: number
    sql: ${TABLE}.CHAPTER ;;
  }

  dimension: chapter_topic {
    type: string
    sql: ${TABLE}.CHAPTER_TOPIC ;;
  }

  dimension: edition {
    type: number
    sql: ${TABLE}.EDITION ;;
  }

  dimension: primary_key {
    type: number
    sql: ${TABLE}.PRIMARY_KEY ;;
  }

  dimension: product_family {
    type: string
    sql: ${TABLE}.PRODUCT_FAMILY ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}.SECTION ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.UNIT ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
