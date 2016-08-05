- view: dim_user
  sql_table_name: DW_GA.DIM_USER
  fields:

  - dimension: dayssincefirstvisit
    type: string
    sql: ${TABLE}.DAYSSINCEFIRSTVISIT

  - dimension: dayssincelastvisit
    type: string
    sql: ${TABLE}.DAYSSINCELASTVISIT

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension: dw_ldts
    type: string
    sql: ${TABLE}.DW_LDTS

  - dimension: helperpartyid
    type: string
    sql: ${TABLE}.HELPERPARTYID

  - dimension: helperrole
    type: string
    sql: ${TABLE}.HELPERROLE

  - dimension: mainpartyid
    type: string
    sql: ${TABLE}.MAINPARTYID

  - dimension: mainpartyrole
    type: string
    sql: ${TABLE}.MAINPARTYROLE

  - dimension: numberofpageviews
    type: string
    sql: ${TABLE}.NUMBEROFPAGEVIEWS

  - dimension: numberofvisits
    type: string
    sql: ${TABLE}.NUMBEROFVISITS

  - dimension: pageviewtime
    type: string
    sql: ${TABLE}.PAGEVIEWTIME

  - dimension: productsactivated
    type: string
    sql: ${TABLE}.PRODUCTSACTIVATED

  - dimension: sessionviewtime
    type: string
    sql: ${TABLE}.SESSIONVIEWTIME

  - dimension: userid
    type: string
    sql: ${TABLE}.USERID

  - dimension: weekssincefirstactivated
    type: string
    sql: ${TABLE}.WEEKSSINCEFIRSTACTIVATED

  - dimension: weekssincelastactivated
    type: string
    sql: ${TABLE}.WEEKSSINCELASTACTIVATED

  - measure: count
    type: count
    drill_fields: []

