view: course_facts {
  label: "Course / Section Details"
  derived_table: {
    sql: select course.courseid, instructor.instructor_first_date, instructor.instructor_first_date_key
      from
      (SELECT b.userid as instructorid
            , min(datevalue) as instructor_first_date
            , min(a.startdatekey) as instructor_first_date_key
            FROM dw_ga.dim_course  a
            JOIN dw_ga.coursetoinstructor b
            ON a.courseid = b.courseid
            JOIN dw_ga.dim_date d
            on a.startdatekey = d.datekey
            group by 1) instructor
      join dw_ga.coursetoinstructor map
      on instructor.instructorid = map.userid
      join dw_ga.dim_course course
      on map.courseid = course.courseid

       ;;
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: instructor_first_date {
    label: "Instructor's first course start date"
    type: date
    hidden: yes
    sql: ${TABLE}.INSTRUCTOR_FIRST_DATE ;;
  }

  dimension: instructor_first_date_key {
    type: number
    sql: ${TABLE}.INSTRUCTOR_FIRST_DATE_key ;;
    hidden: yes
  }

  dimension: instructor_is_new {
    label: "Instructor is new?"
    type: yesno
    sql: ${instructor_first_date_key} = ${dim_course.startdatekey} ;;
  }

#   set: detail {
#     fields: [courseid, instructor_first_date]
#   }
}
