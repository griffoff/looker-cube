- view: dim_institution
  label: 'Institution'
  sql_table_name: DW_GA.DIM_INSTITUTION
  fields:

  - dimension: city
    group_label: 'Location'
    type: string
    sql: ${TABLE}.CITY

  - dimension: country
    group_label: 'Location'
    type: string
    sql: ${TABLE}.COUNTRY
  
  - dimension: postalcode
    group_label: 'Location'
    label: 'Postal/Zip code'
    type: string
    sql: ${TABLE}.POSTALCODE

  - dimension: region
    group_label: 'Location'
    type: string
    sql: ${TABLE}.REGION
    
  - dimension: locationid
    type: number
    sql: ${TABLE}.locationid
    hidden: true

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
    label: 'Enrollment number (est)'
    type: string
    sql: ${TABLE}.ENROLLMENTNUMBER

  - dimension: entity_no
    label: 'Entity No.'
    type: string
    sql: ${TABLE}.ENTITY_NO

  - dimension: estimatedenrollmentlevel
    label: 'Enrollment level (est)'
    type: tier
    tiers: [50, 100, 500, 1000, 5000, 10000]
    style: integer
    sql: ${TABLE}.ESTIMATEDENROLLMENTLEVEL

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID
    hidden: true
    primary_key: true

  - dimension: institutionname
    label: 'Institution name'
    type: string
    sql: ${TABLE}.INSTITUTIONNAME


  - dimension: marketsegmentmajor
    label: 'Market Segment - Major'
    group_label: 'Market Segment'
    type: string
    sql: ${TABLE}.MARKETSEGMENTMAJOR

  - dimension: marketsegmentminor
    label: 'Market Segment - Minor'
    group_label: 'Market Segment'
    type: string
    sql: ${TABLE}.MARKETSEGMENTMINOR

  - dimension: source
    type: string
    sql: ${TABLE}.SOURCE

  - measure: count
    label: 'No. of institutions'
    type: count
    drill_fields: [institutionname]

