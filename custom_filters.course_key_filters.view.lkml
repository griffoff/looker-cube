explore: course_keys_filter_all {
  hidden: yes

  join: course_keys_filter_1 {
    sql_on: ${course_keys_filter_all.course_key} = ${course_keys_filter_1.course_key} ;;
    #type: full_outer
    relationship: one_to_one
  }

  join: course_keys_filter_2 {
    sql_on: ${course_keys_filter_all.course_key} = ${course_keys_filter_2.course_key} ;;
    relationship: one_to_one
  }

  join: course_keys_filter_09112020 {
    sql_on: ${course_keys_filter_all.course_key} = ${course_keys_filter_09112020.course_key} ;;
    relationship: one_to_one
  }

}

view: course_keys_filter_all {
  derived_table: {
#     sql: SELECT DISTINCT ${dim_course.olr_course_key} as course_key FROM ${dim_course.SQL_TABLE_NAME} ;;
      sql:  SELECT 1 ;;
  }

  dimension: course_key {
    hidden: yes
    primary_key: yes
    sql: ${olr_courses.course_key};;
  }
}

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

view: course_keys_filter_09112020 {
  extends: [course_keys_filter]

  sql_table_name: dw.dw.EXT_COURSE_KEYS_FILTER_09112020 ;;

  dimension: included {label: "Included in Filter File 09112020"}

}
