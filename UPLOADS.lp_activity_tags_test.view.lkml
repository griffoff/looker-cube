view: lp_activity_tags_test {
  sql_table_name: UPLOADS.ZJB.LP_ACTIVITY_TAGS_TEST ;;

  dimension: activity_cluster {
    type: string
    sql: ${TABLE}.ACTIVITY_CLUSTER ;;
  }

  dimension: activity_sub_cluster {
    type: string
    sql: ${TABLE}.ACTIVITY_SUB_CLUSTER ;;
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

  dimension: learning_path_activity_title {
    type: string
    sql: ${TABLE}.LEARNING_PATH_ACTIVITY_TITLE ;;
  }

  dimension: primary_key {
    type: number
    sql: ${TABLE}.PRIMARY_KEY ;;
    primary_key: yes
  }

  dimension: product_family {
    type: string
    sql: ${TABLE}.PRODUCT_FAMILY ;;
  }

  dimension: product_family_edition {
    type: number
    sql: ${TABLE}.PRODUCT_FAMILY_EDITION ;;
  }

  dimension: section_name {
    type: string
    sql: ${TABLE}.SECTION_NAME ;;
  }

  dimension: section_number {
    type: string
    sql: ${TABLE}.SECTION_NUMBER ;;
  }

  measure: count {
    type: count
    drill_fields: [section_name]
  }
}
