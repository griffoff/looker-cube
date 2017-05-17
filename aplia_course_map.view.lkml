view: aplia_course_map {
  derived_table: {
    sql: select distinct guid,context_id from stg_aplia.courses;;
    sql_trigger_value: select count(*) from stg_aplia.courses ;;
    }

  dimension: course_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.COURSE_ID ;;
  }
  dimension: guid {
    hidden: yes
    type: string
    sql: ${TABLE}.GUID ;;
  }
  measure: count {
    label: "# Courses"
    type: count
    drill_fields: [course_id]
  }
}
