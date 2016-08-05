- view: dim_institution
  label: 'Institution'
  sql_table_name: DW_GA.DIM_INSTITUTION
  fields:

  - dimension: city
    type: string
    sql: ${TABLE}.CITY

  - dimension: country
    type: string
    sql: ${TABLE}.COUNTRY

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension: enrollmentnumber
    type: string
    sql: ${TABLE}.ENROLLMENTNUMBER

  - dimension: entity_no
    type: string
    sql: ${TABLE}.ENTITY_NO

  - dimension: estimatedenrollmentlevel
    type: string
    sql: ${TABLE}.ESTIMATEDENROLLMENTLEVEL

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID
    primary_key: true

  - dimension: institutionname
    type: string
    sql: ${TABLE}.INSTITUTIONNAME

  - dimension: locationid
    type: string
    sql: ${TABLE}.LOCATIONID

  - dimension: marketsegmentmajor
    type: string
    sql: ${TABLE}.MARKETSEGMENTMAJOR

  - dimension: marketsegmentminor
    type: string
    sql: ${TABLE}.MARKETSEGMENTMINOR

  - dimension: postalcode
    type: string
    sql: ${TABLE}.POSTALCODE

  - dimension: region
    type: string
    sql: ${TABLE}.REGION

  - dimension: source
    type: string
    sql: ${TABLE}.SOURCE

  - measure: count
    type: count
    drill_fields: [institutionname]

