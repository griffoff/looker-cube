view: aplia_course_map {
  view_label: "Course"
  derived_table: {
    sql:
      select c.guid,course_id,nvl(nullif(mindtap_course_yn, ''),0) as mindtap_course_yn
              ,to_timestamp(max(begin_date), 'MON DD YYYY HH12:MIAM') as begin_date
              ,to_timestamp(max(end_date), 'MON DD YYYY HH12:MIAM') as end_date
              ,case when user_id not like '%aplia.com' and user_id not like  '%cengage.com' then 'T' else 'F' end as valid_course
      from stg_aplia.course c
      inner  join stg_aplia.membership m on m.context_guid = c.guid and m.role_guid = 'ROLE041651A500E908EF3A1E80000000'
      inner join stg_aplia.apliauser au on m.user_guid= au.guid
      group by 1, 2, 3,au.user_id;;

    sql_trigger_value: select count(c.guid,course_id,nvl(nullif(mindtap_course_yn, ''),0) as mindtap_course_yn
              ,to_timestamp(max(begin_date), 'MON DD YYYY HH12:MIAM') as begin_date
              ,to_timestamp(max(end_date), 'MON DD YYYY HH12:MIAM') as end_date
              ,case when user_id not like '%aplia.com' and user_id not like  '%cengage.com' then 'T' else 'F' end as valid_course)       from stg_aplia.course c
      inner  join stg_aplia.membership m on m.context_guid = c.guid and m.role_guid = 'ROLE041651A500E908EF3A1E80000000'
      inner join stg_aplia.apliauser au on m.user_guid= au.guid
      group by 1, 2, 3,au.user_id ;;
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
