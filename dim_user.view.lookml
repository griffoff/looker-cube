- view: dim_user
  label: 'User'
  sql_table_name: DW_GA.DIM_USER
  fields:

  - dimension: dayssincefirstvisit
    label: 'Days since first visit'
    type: number
    sql: ${TABLE}.DAYSSINCEFIRSTVISIT
    
  - dimension: weekssincefirstvisit
    label: 'Weeks since first visit'
    type: tier
    style: integer
    tiers: [1, 4, 12, 26, 52, 104] 
    sql: ${dayssincefirstvisit}

  - dimension: dayssincelastvisit
    label: 'Days since last visit'
    type: tier
    tiers: [1, 2, 3, 5, 7, 14, 21]
    style: integer
    sql: ${TABLE}.DAYSSINCELASTVISIT
    
  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true
    
  - dimension: dw_ldts
    type: string
    sql: ${TABLE}.DW_LDTS
    hidden: true
  
  - dimension: helperpartyid
    type: string
    sql: ${TABLE}.HELPERPARTYID
    hidden: true
    
  - dimension: helperrole
    type: string
    sql: ${TABLE}.HELPERROLE
    hidden: true
    
  - dimension: mainpartyid
    type: string
    sql: ${TABLE}.MAINPARTYID
    hidden: true
    
  - dimension: mainpartyrole
    label: 'User Role'
    type: string
    sql: ${TABLE}.MAINPARTYROLE
    
  - dimension: numberofpageviews
    label: 'Total no. of page views'
    type: tier
    tiers: [10, 100, 1000, 5000, 10000]
    style: integer
    sql: ${TABLE}.NUMBEROFPAGEVIEWS

  - dimension: numberofvisits
    label: 'Total no. of visits'
    type: tier
    tiers: [1, 10, 20, 50, 100]
    style: integer
    sql: ${TABLE}.NUMBEROFVISITS

  - dimension: pageviewtime
    label: 'Total page view time'
    type: number
    sql: ${TABLE}.PAGEVIEWTIME

  - dimension: productsactivated
    label: 'No. of products activated'
    type: tier
    tiers: [1, 2, 3, 5, 10]
    style: integer
    sql: ${TABLE}.PRODUCTSACTIVATED

  - dimension: sessionviewtime
    label: 'Total session view time'
    type: number
    sql: ${TABLE}.SESSIONVIEWTIME

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID
    hidden: true
    primary_key: true
    
  - dimension: weekssincefirstactivated
    label: 'Weeks since first activated'
    type: tier
    style: integer
    tiers: [1, 4, 12, 26, 52, 104]
    sql: ${TABLE}.WEEKSSINCEFIRSTACTIVATED

  - dimension: weekssincelastactivated
    label: 'Weeks since last activated'
    type: tier
    style: integer
    tiers: [1, 4, 12, 26, 52, 104]
    sql: ${TABLE}.WEEKSSINCELASTACTIVATED

  - measure: count
    label: 'No. of user accounts'
    type: count
    drill_fields: []

