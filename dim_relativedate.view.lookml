- view: dim_relativedate
  label: 'Relative Date'
  sql_table_name: DW_GA.DIM_RELATIVEDATE
  fields:

  - dimension: category
    type: string
    sql: ${TABLE}.CATEGORY

  - dimension: days
    type: number
    hidden: true
    primary_key: true
    sql: ${TABLE}.DAYS

  - dimension: daysname
    label: 'Relative Days'
    type: string
    sql: ${TABLE}.DAYSNAME
    order_by_field: days

  - dimension: daysbucket
    label: 'Relative Days Bucket'
    type: tier
    tiers: [1, 2, 3, 7, 14, 21]
    style: integer
    sql: ${TABLE}.DAYS
    value_format: '0 \d\a\y\s \b\e\f\o\r\e;0 \d\a\y\s \a\f\t\e\r'

  - dimension: months
    type: string
    sql: ${TABLE}.MONTHS
    hidden: true

  - dimension: monthsname
    label: 'Relative Months'
    type: string
    sql: ${TABLE}.MONTHSNAME
    order_by_field: months
    
  - dimension: monthsbucket
    label: 'Relative Months Bucket'
    type: tier
    tiers: [1, 2, 3, 6, 12, 24]
    style: integer
    sql: ${TABLE}.DAYS
    value_format: '0 \m/t/h/s'

  - dimension: weeks
    hidden: true
    type: number
    sql: ${TABLE}.WEEKS

  - dimension: weeksname
    label: 'Relative Weeks'
    type: string
    sql: ${TABLE}.WEEKSNAME
    order_by_field: weeks
    
- view: dim_relative_to_start_date
  extends: [dim_relativedate]
  label: 'Relative To Start Date'
  
- view: dim_relative_to_end_date
  extends: [dim_relativedate]
  label: 'Relative to End Date'
  
- view: dim_relative_to_due_date
  extends: [dim_relativedate]
  label: 'Relative to Due Date'

