- view: dim_iframeapplication
  sql_table_name: DW_GA.DIM_IFRAMEAPPLICATION
  fields:

  - dimension: displayname
    type: string
    sql: ${TABLE}.DISPLAYNAME

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: iframeapplicationid
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID

  - dimension: iframeapplicationname
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONNAME

  - measure: count
    type: count
    drill_fields: [iframeapplicationname, displayname]

