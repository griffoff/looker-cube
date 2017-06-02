view: problem {
  derived_table: {
    sql: select p.* from stg_aplia.problem  AS p
    inner JOIN prod.STG_APLIA.APLIACONTENT  AS ct ON p.PROBLEM_SET_GUID = ct.GUID
    WHERE  length(p.guid) = 32
    AND (p.guid like('%PL%')
    or p.guid like('%QNA%'))
    order by problem_id,problem_set_guid;;

      sql_trigger_value: select count(*) from stg_aplia.problem  AS p
    inner JOIN prod.STG_APLIA.APLIACONTENT  AS ct ON p.PROBLEM_SET_GUID = ct.GUID
    WHERE  length(p.guid) = 32
    AND (p.guid like('%PL%')
    or p.guid like('%QNA%'));;
    }
 # sql_table_name: STG_APLIA.PROBLEM ;;

  dimension: problem_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.PROBLEM_ID ;;
  }

  dimension: answer_type {
    type: string
    sql: ${TABLE}.ANSWER_TYPE ;;
  }

  dimension: correct_answer_image_id {
    type: string
    sql: ${TABLE}.CORRECT_ANSWER_IMAGE_ID ;;
  }

  dimension: deleted {
    type: string
    sql: ${TABLE}.DELETED ;;
  }

  dimension: deleted_date {
    type: string
    sql: ${TABLE}.DELETED_DATE ;;
  }

  dimension: difficulty_level {
    type: string
    sql: ${TABLE}.DIFFICULTY_LEVEL ;;
  }

  dimension: explanation {
    type: string
    sql: ${TABLE}.EXPLANATION ;;
  }

  dimension: explanation_html_object {
    type: string
    sql: ${TABLE}.EXPLANATION_HTML_OBJECT ;;
  }

  dimension: explanation_html_object_layout {
    type: string
    sql: ${TABLE}.EXPLANATION_HTML_OBJECT_LAYOUT ;;
  }

  dimension: guid {
    type: string
    sql: ${TABLE}.GUID ;;
  }

  dimension: heading_id {
    type: string
    sql: ${TABLE}.HEADING_ID ;;
  }

  dimension: html_object {
    type: string
    sql: ${TABLE}.HTML_OBJECT ;;
  }

  dimension: layout {
    type: string
    sql: ${TABLE}.LAYOUT ;;
  }

  dimension: major_sort_index_num {
    type: string
    sql: ${TABLE}.MAJOR_SORT_INDEX_NUM ;;
  }

  dimension: manually_graded_yn {
    type: string
    sql: ${TABLE}.MANUALLY_GRADED_YN ;;
  }

  dimension: minor_sort_index_num {
    type: string
    sql: ${TABLE}.MINOR_SORT_INDEX_NUM ;;
  }

  dimension: points {
    type: string
    sql: ${TABLE}.POINTS ;;
  }

  dimension: points_customized_yn {
    type: string
    sql: ${TABLE}.POINTS_CUSTOMIZED_YN ;;
  }

  dimension: problem_group_guid {
    type: string
    sql: ${TABLE}.PROBLEM_GROUP_GUID ;;
  }

  dimension: problem_index {
    type: string
    sql: ${TABLE}.PROBLEM_INDEX ;;
  }

  dimension: problem_set_guid {
    type: string
    sql: ${TABLE}.PROBLEM_SET_GUID ;;
  }

  dimension: problem_title {
    type: string
    sql: ${TABLE}.PROBLEM_TITLE ;;
  }

  dimension: problem_version {
    type: string
    sql: ${TABLE}.PROBLEM_VERSION ;;
  }

  dimension: question {
    type: string
    sql: ${TABLE}.QUESTION ;;
  }

  dimension: question_display_num {
    type: string
    sql: ${TABLE}.QUESTION_DISPLAY_NUM ;;
  }

  dimension: question_image_id {
    type: string
    sql: ${TABLE}.QUESTION_IMAGE_ID ;;
  }

  dimension: style {
    type: string
    sql: ${TABLE}.STYLE ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.URL ;;
  }

  measure: count {
    label: "# Problems"
    type: count
    drill_fields: [problem_id, problem_title, question_display_num, question]
  }
}
