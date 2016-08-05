- view: dim_party
  sql_table_name: DW_GA.DIM_PARTY
  fields:

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: firstname
    type: string
    sql: ${TABLE}.FIRSTNAME

  - dimension: guid
    type: string
    sql: ${TABLE}.GUID

  - dimension: lastname
    type: string
    sql: ${TABLE}.LASTNAME

  - dimension: mainpartyemail
    type: string
    sql: ${TABLE}.MAINPARTYEMAIL

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID

  - measure: count
    type: count
    drill_fields: [firstname, lastname]

