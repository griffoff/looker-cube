view: mtmf_library_lo_lookup {
  sql_table_name: LOOKER_SCRATCH.MTMF_LIBRARY_LO_LOOKUP ;;

  dimension: cognitive_level_1_knows_2_determines_3_produces {
    type: number
    sql: ${TABLE}.COGNITIVE_LEVEL_1_KNOWS_2_DETERMINES_3_PRODUCES ;;
  }

  dimension: content_development_comments {
    type: string
    sql: ${TABLE}.CONTENT_DEVELOPMENT_COMMENTS ;;
  }

  dimension: market_comments {
    type: string
    sql: ${TABLE}.MARKET_COMMENTS ;;
  }

  dimension: math_learning_objective_level_3 {
    type: string
    sql: ${TABLE}.MATH_LEARNING_OBJECTIVE_LEVEL_3 ;;
  }

  dimension: math_learning_outcome {
    type: string
    sql: ${TABLE}.MATH_LEARNING_OUTCOME ;;
  }

  dimension: math_lo_code {
    type: number
    sql: ${TABLE}.MATH_LO_CODE ;;
  }

  dimension: math_subtopic {
    type: string
    sql: ${TABLE}.MATH_SUBTOPIC ;;
  }

  dimension: math_subtopic_code {
    type: string
    sql: ${TABLE}.MATH_SUBTOPIC_CODE ;;
  }

  dimension: math_topic {
    type: string
    sql: ${TABLE}.MATH_TOPIC ;;
  }

  dimension: math_topic_code {
    type: number
    sql: ${TABLE}.MATH_TOPIC_CODE ;;
  }

  dimension: prerequisites {
    type: string
    sql: ${TABLE}.PREREQUISITES ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.PRODUCT ;;
  }

  dimension: source_lo_code {
    type: string
    sql: ${TABLE}.SOURCE_LO_CODE ;;
  }

  dimension: source_objective_suffix_code {
    type: string
    sql: ${TABLE}.SOURCE_OBJECTIVE_SUFFIX_CODE ;;
  }

  dimension: source_outcome_code {
    type: number
    sql: ${TABLE}.SOURCE_OUTCOME_CODE ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: where_are_known_opportunities_ {
    type: string
    sql: ${TABLE}.WHERE_ARE_KNOWN_OPPORTUNITIES_ ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
