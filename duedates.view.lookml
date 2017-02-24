- view: duedates
  sql_table_name: dev.REPORTS.DUEDATES
  fields:

  - dimension: activitylabel
    type: string
    sql: ${TABLE}.ACTIVITYLABEL

  - dimension: category
    type: string
    sql: ${TABLE}.CATEGORY

  - dimension: coursekey
    type: string
    sql: ${TABLE}.COURSE_KEY

  - dimension: course_name
    type: string
    sql: ${TABLE}.COURSE_NAME

  - dimension_group: duedate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DUEDATE

  - dimension: entity_name_course
    type: string
    sql: ${TABLE}.ENTITY_NAME_COURSE

  - dimension: gradable
    type: string
    sql: ${TABLE}.GRADABLE

  - dimension: homework
    type: string
    sql: ${TABLE}.HOMEWORK

  - dimension: platform
    type: string
    sql: ${TABLE}.PLATFORM

  - measure: students
    type: sum
    sql: ${TABLE}.STUDENTS

