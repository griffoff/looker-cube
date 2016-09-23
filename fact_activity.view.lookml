- view: fact_activity
  label: 'Learning Path Modifications'
  sql_table_name: DW_GA.FACT_ACTIVITY
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.ID
    hidden: true

  - dimension: activityid
    type: string
    sql: ${TABLE}.ACTIVITYID
    hidden: true

  - dimension: courseid
    type: string
    hidden: true
    sql: ${TABLE}.COURSEID

  - dimension: coursesnapshoteventid
    type: string
    sql: ${TABLE}.COURSESNAPSHOTEVENTID
    hidden: true

  - dimension: createddatekey
    type: string
    sql: ${TABLE}.CREATEDDATEKEY
    hidden: true

  - dimension: daysbeforecourseend
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND
    hidden: true

  - dimension: daysfromcoursestart
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART
    hidden: true
    
  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true
    
  - dimension: dw_ldts
    type: string
    sql: ${TABLE}.DW_LDTS
    hidden: true
    
  - dimension: eventtypeid
    type: string
    sql: ${TABLE}.EVENTTYPEID
    hidden: true
    
  - dimension: filterflag
    type: string
    sql: ${TABLE}.FILTERFLAG

  - dimension: institutionid
    type: string
    sql: ${TABLE}.INSTITUTIONID
    hidden: true
    
  - dimension: institutionlocationid
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID
    hidden: true
    
  - dimension: learningpathid
    type: string
    sql: ${TABLE}.LEARNINGPATHID
    hidden: true
    
  - dimension: loaddate
    type: string
    sql: ${TABLE}.LOADDATE
    hidden: true
    
  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID
    hidden: true
    
  - dimension: productid
    type: string
    sql: ${TABLE}.PRODUCTID
    hidden: true
    
  - dimension: snapshotid
    type: string
    sql: ${TABLE}.SNAPSHOTID
    hidden: true
    
  - dimension: timekey
    type: string
    sql: ${TABLE}.TIMEKEY
    hidden: true
    
  - dimension: userid
    type: string
    sql: ${TABLE}.USERID
    hidden: true
    
  - measure: count
    label: 'No. of Actions'
    type: count
    drill_fields: [dim_product.discipline, dim_institution.institutionname, dim_activity.assignment_status, dim_learningpath.lowest_level, count]

