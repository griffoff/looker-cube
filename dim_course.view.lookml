- view: dim_course
  label: 'Course'
  sql_table_name: DW_GA.DIM_COURSE
  fields:

  - dimension: courseid
    type: string
    sql: ${TABLE}.COURSEID
    hidden: true

  - dimension: coursekey
    label: 'Course Key'
    type: string
    sql: ${TABLE}.COURSEKEY
    primary_key: true
    links:
    - label: Engagement Toolkit (Looker)
      url: https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{value}}
    - label: Engagement Toolkit (Dev)
      url: http://dashboard-dev.cengage.info/engtoolkit/{{value}}
    - label: Engagement Toolkit - Discipline (Dev)
      url: http://dashboard-dev.cengage.info/engtoolkit/discipline/{{dim_product.hed_discipline._value}}

  - dimension: coursename
    label: 'Course Name'
    type: string
    sql: ${TABLE}.COURSENAME
    links:
    - label: Engagement Toolkit Looker
      url: https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{dim_course.coursekey._value}}
    - label: Engagement Toolkit (Dev)
      url: http://dashboard-dev.cengage.info/engtoolkit/{{value}}
    - label: Engagement Toolkit (Live)
      url: http://dashboard.cengage.info/engtoolkit/{{value}}

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension: enddatekey
    type: string
    sql: ${TABLE}.ENDDATEKEY
    hidden: true

  - dimension: filterflag
    label: 'Exclusion Rule (filter flag)'
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID
    hidden: true

  - dimension: learningcourse
    type: string
    sql: ${TABLE}.LEARNINGCOURSE
    hidden: true

  - dimension_group: loaddate
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.LOADDATE
    hidden: true

  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID
    hidden: true
  
  - dimension: productplatformid
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID
    hidden: true

  - dimension: startdatekey
    type: string
    sql: ${TABLE}.STARTDATEKEY
    hidden: true

  - measure: count
    label: 'No. of Courses'
    type: count
    drill_fields: [coursename]

