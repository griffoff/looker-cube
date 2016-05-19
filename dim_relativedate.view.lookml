- view: dim_relativedate
  sql_table_name: DW.DIM_RELATIVEDATE
  fields:

  - dimension: category
    type: string
    sql: ${TABLE}.CATEGORY

  - dimension: days
    type: string
    sql: ${TABLE}.DAYS

  - dimension: daysname
    type: string
    sql: ${TABLE}.DAYSNAME

  - dimension: months
    type: string
    sql: ${TABLE}.MONTHS

  - dimension: monthsname
    type: string
    sql: ${TABLE}.MONTHSNAME

  - dimension: weeks
    type: string
    sql: ${TABLE}.WEEKS

  - dimension: weeksname
    type: string
    sql: ${TABLE}.WEEKSNAME

  - measure: count
    type: count
    drill_fields: [daysname, weeksname, monthsname]

