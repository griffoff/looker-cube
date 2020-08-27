view: course_keys_filter {
  extension: required

  label: "** CUSTOM FILTERS **"

  drill_fields: [course_key, source, included]

  dimension: course_key {
    type: string
    sql: ${TABLE}.course_key ;;
    hidden: yes
    primary_key: yes
  }

  dimension: source {
    description: "Name of uploaded file containing these course keys"
    sql: split_part(${TABLE}.filename, '/', -1) ;;
    hidden: yes
  }

  dimension: included {
    group_label: "Course Key Filters"
    type: yesno
    sql: ${course_key} IS NOT NULL ;;
  }

  measure: count {
    hidden: yes
    type: count
  }
}


view: course_keys_filter_1 {
  extends: [course_keys_filter]

  sql_table_name: dw.dw.ext_course_keys_filter ;;

  dimension: included {label: "Included in Filter File 1"}

}

view: course_keys_filter_2 {
  extends: [course_keys_filter]

  sql_table_name: dw.dw.ext_course_keys_filter_2 ;;

  dimension: included {label: "Included in Filter File 2"}

}
