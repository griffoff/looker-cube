view: aplia_course_map {
  view_label: "Course"
  derived_table: {
    sql:
      select guid,course_id,nullif(mindtap_course_yn, '') as mindtap_course_yn
              ,to_timestamp(max(begin_date), 'MON DD YYYY HH12:MIAM') as begin_date
              ,to_timestamp(max(end_date), 'MON DD YYYY HH12:MIAM') as end_date
      from stg_aplia.course
      group by 1, 2, 3;;

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
  dimension: mindtap_course_yn {
    hidden: yes
    type: number
    sql: ${TABLE}.mindtap_course_yn ;;
  }

  dimension_group: begin_date {
    type: time
    timeframes: [date, day_of_week, month_name, year]
  }

  measure: count {
    label: "# Courses"
    type: count
    drill_fields: [course_id]
  }
}
