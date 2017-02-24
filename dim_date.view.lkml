view: dim_date {
  label: "Date"
  sql_table_name: DW_GA.DIM_DATE ;;

  dimension: datevalue {
    label: "Date"
    type: date
    sql: ${TABLE}.datevalue ;;
    hidden: yes
  }

  dimension: calendarmonthid {
    type: string
    sql: ${TABLE}.CALENDARMONTHID ;;
    hidden: yes
  }

  dimension: calendarmonthname {
    type: string
    sql: ${TABLE}.CALENDARMONTHNAME ;;
    label: "Calendar Month"
    group_label: "Calendar - Gregorian Calendar"
    order_by_field: calendarmonthid
  }

  dimension: calendarmonthofyearid {
    type: string
    sql: ${TABLE}.CALENDARMONTHOFYEARID ;;
    hidden: yes
  }

  dimension: calendarmonthofyearname {
    type: string
    sql: ${TABLE}.CALENDARMONTHOFYEARNAME ;;
    label: "Calendar Month of Year"
    group_label: "Calendar - Gregorian Calendar"
    order_by_field: calendarmonthofyearid
  }

  dimension: calendarmonthofyearnameshort {
    label: "Calendar Month of Year (short)"
    group_label: "Calendar - Gregorian Calendar"
    order_by_field: calendarmonthofyearid
    type: string
    sql: ${TABLE}.CALENDARMONTHOFYEARNAMESHORT ;;
  }

  dimension: calendaryearvalue {
    type: number
    sql: ${TABLE}.CALENDARYEARVALUE ;;
    label: "Calendar Year"
    group_label: "Calendar - Gregorian Calendar"
    value_format: "0000"
  }

  dimension: cengageacademicterm {
    type: string
    sql: ${TABLE}.CENGAGEACADEMICTERM ;;
    label: "Cengage Academic Term"
    group_label: "Calendar - Cengage Academic Calendar"
    order_by_field: cengageacademictermid
  }

  dimension: cengageacademictermid {
    type: string
    sql: ${TABLE}.CENGAGEACADEMICTERMID ;;
    hidden: yes
  }

  dimension: cengageacademicyear {
    type: number
    sql: ${TABLE}.CENGAGEACADEMICYEAR ;;
    label: "Cengage Academic Year"
    group_label: "Calendar - Cengage Academic Calendar"
    value_format: "0000"
  }

  dimension: datekey {
    type: string
    primary_key: yes
    sql: ${TABLE}.DATEKEY ;;
    hidden: yes
  }

  dimension_group: datevalue {
    type: time
    timeframes: [
      date,
      week,
      month,
      year,
      day_of_week
    ]
    convert_tz: no
    sql: ${TABLE}.DATEVALUE ;;
    label: "Date"
  }

  dimension: dayofweekid {
    type: string
    sql: ${TABLE}.DAYOFWEEKID ;;
    hidden: yes
  }

  dimension: dayofweekname {
    type: string
    sql: ${TABLE}.DAYOFWEEKNAME ;;
    label: "Day of Week"
    order_by_field: dayofweekid
  }

  dimension: dayofweeknameshort {
    type: string
    sql: ${TABLE}.DAYOFWEEKNAMESHORT ;;
    label: "Day of Week (short)"
    order_by_field: dayofweekid
  }

  dimension: governmentdefinedacademicterm {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERM ;;
    label: "Government Academic Term"
    group_label: "Calendar - Government Defined Academic Calendar"
    order_by_field: governmentdefinedacademictermid
  }

  dimension: governmentdefinedacademicterm_description {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERM_DESCRIPTION ;;
    hidden: yes
  }

  dimension: governmentdefinedacademictermid {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERMID ;;
    hidden: yes
  }

  dimension: governmentdefinedacademictermyear {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERMYEAR ;;
    label: "Government Academic Year"
    group_label: "Calendar - Government Defined Academic Calendar"
  }

  dimension: hed_academicterm {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERM ;;
    label: "HED Academic Term"
    group_label: "Calendar - HED Academic Calendar"
    order_by_field: hed_academictermid
  }

  dimension: hed_academictermid {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERMID ;;
    hidden: yes
  }

  dimension: hed_academictermofyear {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERMOFYEAR ;;
    label: "HED Academic Term of Year"
    group_label: "Calendar - HED Academic Calendar"
    order_by_field: hed_academictermofyearid
  }

  dimension: hed_academictermofyearid {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERMOFYEARID ;;
    hidden: yes
  }

  dimension: hed_academicyear {
    type: number
    sql: ${TABLE}.HED_ACADEMICYEAR ;;
    label: "HED Academic Year"
    group_label: "Calendar - HED Academic Calendar"
    value_format: "0000"
  }

  dimension: isoweekid {
    type: string
    sql: ${TABLE}.ISOWEEKID ;;
    hidden: yes
  }

  dimension: isoweekname {
    type: string
    sql: ${TABLE}.ISOWEEKNAME ;;
    label: "ISO Week"
    group_label: "Calendar - ISO Calendar"
    order_by_field: isoweekid
  }

  dimension: isoweekofyearid {
    type: string
    sql: ${TABLE}.ISOWEEKOFYEARID ;;
    hidden: yes
  }

  dimension: isoweekofyearname {
    type: string
    sql: ${TABLE}.ISOWEEKOFYEARNAME ;;
    label: "ISO Week of Year"
    group_label: "Calendar - ISO Calendar"
    order_by_field: isoweekofyearid
  }

  dimension: isoyearvalue {
    type: string
    sql: ${TABLE}.ISOYEARVALUE ;;
    label: "ISO Year"
    group_label: "Calendar - ISO Calendar"
  }

  dimension: isweekend {
    type: string
    sql: ${TABLE}.ISWEEKEND ;;
    hidden: yes
  }

  dimension: isweekendname {
    type: string
    sql: ${TABLE}.ISWEEKENDNAME ;;
    label: "Is Weekend"
    order_by_field: isweekend
  }

  dimension: libertyacademicterm {
    type: string
    sql: ${TABLE}.LIBERTYACADEMICTERM ;;
    label: "Liberty Academic Term"
    group_label: "Calendar - Liberty Calendar"
    order_by_field: libertyacademictermid
  }

  dimension: libertyacademictermid {
    type: string
    sql: ${TABLE}.LIBERTYACADEMICTERMID ;;
    hidden: yes
  }

  dimension: libertyacademictermofyear {
    type: string
    sql: ${TABLE}.LIBERTYACADEMICTERMOFYEAR ;;
    label: "Liberty Academic Term of Year"
    group_label: "Calendar - Liberty Calendar"
    order_by_field: libertyacademictermofyearid
  }

  dimension: libertyacademictermofyearid {
    type: string
    sql: ${TABLE}.LIBERTYACADEMICTERMOFYEARID ;;
    hidden: yes
  }

  measure: count {
    label: "No. of Days"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      datevalue,
      dayofweekname,
      calendarmonthofyearname,
      calendaryearvalue
    ]
  }
}

view: dim_start_date {
  extends: [dim_date]
  label: "Course Start Date"
}

view: dim_end_date {
  extends: [dim_date]
  label: "Course End Date"
}

view: dim_created_date {
  extends: [dim_date]
  label: "Created Date"
}

view: dim_first_used_date {
  extends: [dim_date]
  label: "First Used Date"
}

view: dim_completion_date {
  extends: [dim_date]
  label: "Completion Date"
}
