- view: dim_iframeapplication
  label: 'App Dock'
  sql_table_name: DW_GA.DIM_IFRAMEAPPLICATION
  fields:

  - dimension: displayname
    label: 'Display Name'
    type: string
    sql: COALESCE(${TABLE}.DISPLAYNAME, ${iframeapplicationname})

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID
    hidden: true

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS
    hidden: true
    
  - dimension: iframeapplicationid
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID
    hidden: true
    primary_key: true
    
  - dimension: iframeapplicationname
    label: 'Application Name'
    type: string
    sql: REPLACE(REPLACE(REPLACE(REPLACE(${TABLE}.IFRAMEAPPLICATIONNAME, '_', ' '), 'LAUNCH', ''), 'VIEW', ''), 'FLASH CARDS', 'FLASHCARDS')

  - measure: count
    type: count
    drill_fields: [iframeapplicationname, displayname]

