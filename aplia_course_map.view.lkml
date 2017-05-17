view: aplia_course_map {
  view_label: "Aplia Course"
  derived_table: {
    sql: select distinct guid,course_id from stg_aplia.course;;
    sql_trigger_value: select count(*) from stg_aplia.course ;;
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
