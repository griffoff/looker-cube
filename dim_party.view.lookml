- view: dim_party
  label: 'User'
  sql_table_name: DW_GA.DIM_PARTY
  fields:

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true

  - dimension: firstname
    type: string
    sql: ${TABLE}.FIRSTNAME
    hidden: true

  - dimension: guid
    type: string
    sql: ${TABLE}.GUID

  - dimension: lastname
    label: 'Last name'
    group_label: 'PII'
    type: string
    sql: ${TABLE}.LASTNAME
    #hidden: true

  - dimension: mainpartyemail
    group_label: 'PII'
    label: 'e-mail address'
    type: string
    sql: ${TABLE}.MAINPARTYEMAIL
    #hidden: true

  - dimension: partyid
    type: string
    sql: ${TABLE}.PARTYID
    primary_key: true
    hidden: true

  - measure: count
    label: 'No. of people'
    type: count
    drill_fields: [guid]

