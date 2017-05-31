view: aplia_course_map {
  view_label: "Course"
  derived_table: {
    sql:
      with filter_instructors as (
        --courses with instructors whose id ends with given endings
        --or with "ademo" context-ids
        select context_guid
        from stg_aplia.membership m
        inner join stg_aplia.apliauser au on m.user_guid= au.guid
        where m.role_guid='ROLE041651A500E908EF3A1E80000000'
        and (
             user_id like '%aplia.com'
          or user_id like  '%cengage.com'
          )
      )
      ,filter_students as (
        --courses with less than 3 students
        select context_guid
        from stg_aplia.membership m
        where m.role_guid='ROLE041651A500E908EE3FFE80000000'
        group by 1
        having count(*) < 3
      )
      select c.guid,c.course_id,nvl(nullif(c.mindtap_course_yn, ''),0) as mindtap_course_yn
              ,case
                  when i.context_guid is null
                      and s.context_guid is null
                      and ac.context_id not like 'ademo%'
                  then True else False
               end as valid_course
              ,to_timestamp(max(begin_date), 'MON DD YYYY HH12:MIAM') as begin_date
              ,to_timestamp(max(end_date), 'MON DD YYYY HH12:MIAM') as end_date
      from stg_aplia.course c
      left join filter_instructors i on c.guid = i.context_guid
      left join filter_students s on c.guid = s.context_guid
      left join stg_aplia.apliacontext ac on c.guid = ac.guid
      group by 1, 2, 3, 4;;

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

  dimension: valid_course {
    label: "Real Course"
    description: "Flag to identify real courses, rather than test/demo/internal"
    type: yesno
    sql: ${TABLE}.valid_course ;;
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
