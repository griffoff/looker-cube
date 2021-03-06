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
    label: "Day of Course"
    description: "Days Relative to Course Start Date"
    hidden: no
    type: number
    sql: ${days} ;;
    value_format: "\D\a\y 0"
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
    label: "Month of Course"
    description: "No. of Months from Course Start Date"
    hidden: yes
    type: string
    sql: ${TABLE}.MONTHSNAME ;;
    order_by_field: months
  }

  dimension: monthsbucket {
    label: "Relative Months Bucket"
    type: tier
#     hidden: yes
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
    value_format: "0 \m\t\h\s"
  }

  dimension: weeks {
    label: "Week No."
    description: "Week No. relative to Course Start Date"
    type: number
    hidden: yes
    sql: ${TABLE}.WEEKS ;;
  }

  dimension: weeksname {
    label: "Week of Course"
    description: "Weeks Relative to Course Start Date"
    type: number
    sql: ${TABLE}.WEEKS ;;
    value_format: "\W\e\e\k 0"
  }

  dimension: weeksname_bucket {
    label: "Weeks Relative to Course Start Date (Buckets)"
    description: "Using for RFI Dashboard element. Please hide when finished setting up"
    type: string
    hidden: yes
    sql:
            CASE
                WHEN ${weeksname} <0 THEN 'Pre-Class'
                WHEN ${weeksname} BETWEEN 0 AND 2 THEN 'Weeks 0-2'
                WHEN ${weeksname} BETWEEN 3 AND 8 THEN 'Weeks 3-8'
                WHEN ${weeksname} >= 9 THEN 'Weeks 9+'
                ELSE NULL
            END;;
  }

  measure: max_weeks {
    label: "Max Weeks"
    description: "Latest week with activity"
    type: number
    sql: MAX(${TABLE}.WEEKS) ;;
    hidden: yes
  }
}

view: dim_relative_to_start_date {
  extends: [dim_relativedate]
  label: "Course / Section Details"

  dimension: weeksname {group_label: "Course Start Date"}
  dimension: daysname {group_label: "Course Start Date"}
  dimension: monthsbucket {hidden: yes group_label: "Course Start Date"}
}

view: dim_relative_to_end_date {
  extends: [dim_relativedate]
  label: "Relative to End Date"
}

view: dim_relative_to_due_date {
  extends: [dim_relativedate]
  label: "Relative to Due Date"
}
