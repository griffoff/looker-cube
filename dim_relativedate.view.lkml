view: dim_relativedate {
  label: "Relative Date"
  sql_table_name: DW_GA.DIM_RELATIVEDATE ;;

  dimension: category {
    type: string
    hidden: yes
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: days {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.DAYS ;;
  }

  dimension: daysname {
    label: "Relative Days"
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSNAME ;;
    order_by_field: days
  }

  dimension: daysbucket {
    label: "Relative Days Bucket"
    type: tier
    hidden: yes
    tiers: [
      1,
      2,
      3,
      7,
      14,
      21
    ]
    style: integer
    sql: ${TABLE}.DAYS ;;
    value_format: "0 \d\a\y\s \b\e\f\o\r\e;0 \d\a\y\s \a\f\t\e\r"
  }

  dimension: months {
    type: string
    sql: ${TABLE}.MONTHS ;;
    hidden: yes
  }

  dimension: monthsname {
    label: "Relative Months"
    hidden: yes
    type: string
    sql: ${TABLE}.MONTHSNAME ;;
    order_by_field: months
  }

  dimension: monthsbucket {
    label: "Relative Months Bucket"
    type: tier
    hidden: yes
    tiers: [
      1,
      2,
      3,
      6,
      12,
      24
    ]
    style: integer
    sql: ${TABLE}.DAYS ;;
    value_format: "0 \m/t/h/s"
  }

  dimension: weeks {
    label: "Week No. Relative to Course Start Date"
    type: number
    hidden: yes
    sql: ${TABLE}.WEEKS ;;
  }

  dimension: weeksname {
    label: "Weeks Relative to Course Start Date"
    type: number
    sql: ${TABLE}.WEEKS ;;
    value_format: "\W\e\e\k 0"
  }

  measure: max_weeks {
    label: "Max Weeks"
    description: "Latest week with activity"
    type: number
    sql: MAX(${TABLE}.WEEKS) ;;
    type: number
    hidden: yes
  }
}

view: dim_relative_to_start_date {
  extends: [dim_relativedate]
  label: "Date - Course Start Date"
}

view: dim_relative_to_end_date {
  extends: [dim_relativedate]
  label: "Relative to End Date"
}

view: dim_relative_to_due_date {
  extends: [dim_relativedate]
  label: "Relative to Due Date"
}
