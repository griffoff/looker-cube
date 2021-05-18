view: dim_date {
  label: "Date"

  derived_table: {
    sql: select *
      ,row_number() over (partition by GOVERNMENTDEFINEDACADEMICTERM order by DATEVALUE) as day_of_term
      ,ceil(day_of_term/7) as week_of_term
    from prod.dm_common.dim_date_legacy_cube;;
    datagroup_trigger: daily_refresh
  }

#   sql_table_name: prod.dm_common.dim_date_legacy_cube ;;
#   sql_table_name: DW_GA.DIM_DATE ;;

  set: curated_fields {fields:[datevalue_date,datevalue_month,datevalue_month_name,datevalue_year,datevalue_day_of_week,fiscalyear]}
  set: marketing_fields {fields:[date, governmentdefinedacademicterm]}

  dimension: datevalue {
    label: "Date"
    type: date
    sql: ${TABLE}.datevalue ;;
    hidden: yes
  }

  dimension: date {
    hidden: yes
    sql: ${TABLE}.datevalue;;
    type: date
  }

  dimension: fiscalyear {
    label: "Fiscal Year"
    description: "April 1st to March 31st"
    type: string
    sql: ${TABLE}.fiscalyearvalue ;;
    hidden: no
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
    hidden:  yes
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
    hidden:  yes
  }

  dimension: calendarmonthofyearnameshort {
    label: "Calendar Month of Year (short)"
    group_label: "Calendar - Gregorian Calendar"
    order_by_field: calendarmonthofyearid
    type: string
    sql: ${TABLE}.CALENDARMONTHOFYEARNAMESHORT ;;
    hidden:  yes
  }

  dimension: calendaryearvalue {
    type: number
    sql: ${TABLE}.CALENDARYEARVALUE ;;
    label: "Calendar Year"
    group_label: "Calendar - Gregorian Calendar"
    value_format: "0000"
    hidden:  yes
  }

  dimension: cengageacademicterm {
    type: string
    sql: ${TABLE}.CENGAGEACADEMICTERM ;;
    label: "Cengage Academic Term"
    group_label: "Calendar - Cengage Academic Calendar"
    order_by_field: cengageacademictermid
    hidden:  yes
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
    hidden:  yes
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
      raw,
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      day_of_year,
      week_of_year,
      #quarter_of_year,
#       fiscal_year
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]
    convert_tz: no
    sql: ${TABLE}.DATEVALUE ;;
    label: "Calendar"
    description: "Standard calendar"
    hidden: no
  }

  dimension: dayofweekid {
    type: string
    sql: ${TABLE}.DAYOFWEEKID ;;
    hidden: yes
  }

  dimension: dayofweekname {
    type: string
    hidden: yes
    sql: ${TABLE}.DAYOFWEEKNAME ;;
    label: "Day of Week"
    order_by_field: dayofweekid
  }

  dimension: dayofweeknameshort {
    type: string
    hidden: yes
    sql: ${TABLE}.DAYOFWEEKNAMESHORT ;;
    label: "Day of Week (short)"
    order_by_field: dayofweekid
  }

   dimension: governmentdefinedacademicterm {
     type: string
     description: "Fall = August (8/1) - December (12/31).  Spring = January (1/1) - June (6/30).  Summer = July (7/1-7/31)
     This dimension represents a specific term in a specific year i.e. Fall 2017, not Fall"
     sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERM ;;
     #sql: ${governmentdefinedacademictermofyear} || ' ' || ${governmentdefinedacademictermyear};;
     label: "Academic Term"
#      group_label: "Calendar - Government Defined Academic Calendar"
     order_by_field: governmentdefinedacademictermid
   }

   dimension: governmentdefinedacademictermofyear {
     type: string
     description: "Fall = August (8/1) - December (12/31).  Spring = January (1/1) - June (6/30).  Summer = July (7/1-7/31)
     This dimension represents a specific term regardless of year i.e. Fall, not Fall 2017"
     sql:  split_part(${TABLE}.GOVERNMENTDEFINEDACADEMICTERM, ' ', 1) ;;
     label: "Academic Term of year"
#      group_label: "Calendar - Government Defined Academic Calendar"
     order_by_field: governmentdefinedacademictermofyearid
  }

  dimension: day_of_term {
    type: string
    description: "Day number of academic term [Fall = August (8/1) - December (12/31).  Spring = January (1/1) - June (6/30).  Summer = July (7/1-7/31)]"
    label: "Day of Academic Term"
  }

  dimension: week_of_term {
    type: string
    description: "Week number of academic term [Fall = August (8/1) - December (12/31).  Spring = January (1/1) - June (6/30).  Summer = July (7/1-7/31)]"
    label: "Week of Academic Term"
  }

  dimension: governmentdefinedacademicterm_description {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERM_DESCRIPTION ;;
    hidden: yes
  }

  dimension: governmentdefinedacademictermofyearid {
    type: number
    sql: RIGHT(${TABLE}.GOVERNMENTDEFINEDACADEMICTERMID,2)::int ;;
    hidden: yes
  }


  dimension: governmentdefinedacademictermid {
    type: number
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERMID ;;
    hidden: yes
  }

  dimension: governmentdefinedacademictermyear {
    type: string
    sql: ${TABLE}.GOVERNMENTDEFINEDACADEMICTERMYEAR ;;
    #sql: IFF(${TABLE}.GOVERNMENTDEFINEDACADEMICTERMYEAR = '-1', '-1', regexp_substr(${TABLE}.GOVERNMENTDEFINEDACADEMICTERMYEAR, '\\d{4}') - 1 || '/' || regexp_substr(${TABLE}.GOVERNMENTDEFINEDACADEMICTERMYEAR, '\\d{2}$')) ;;
    label: "Academic Year"
    group_label: "Calendar - Government Defined Academic Calendar"
    hidden: no
  }

  dimension: hed_academicterm {
    type: string
    sql: ${TABLE}.HED_ACADEMICTERM ;;
    label: "HED Academic Term"
    group_label: "Calendar - HED Academic Calendar"
    order_by_field: hed_academictermid
    hidden:  yes
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
    hidden:  yes
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
    hidden:  yes
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
    hidden:  yes
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
    hidden:  yes
  }

  dimension: isoyearvalue {
    type: string
    sql: ${TABLE}.ISOYEARVALUE ;;
    label: "ISO Year"
    group_label: "Calendar - ISO Calendar"
    hidden:  yes
  }

  dimension: isweekend {
    type: string
    sql: ${TABLE}.ISWEEKEND ;;
    hidden: yes
  }

  dimension: isweekendname {
      description: "Weekend / Weekday"
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
    hidden:  yes
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
    hidden:  yes
  }

  dimension: libertyacademictermofyearid {
    type: string
    sql: ${TABLE}.LIBERTYACADEMICTERMOFYEARID ;;
    hidden: yes
  }

  measure: count {
    label: "No. of Days"
    hidden: yes
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
  label: "Course / Section Details"
  dimension: fiscalyear {
     hidden: no
#     sql: ${TABLE}.fiscalyearvalue
    group_label: "Course Start Date"
    group_item_label:"Course Start Fiscal Year"
    }
  dimension: governmentdefinedacademicterm {
    group_label: "Course Start Date"
    group_item_label: "Course Start Academic Term"
    description: "e.g. Fall 2019, Spring 2017, etc. (specific to year)"
    }
  dimension: governmentdefinedacademictermofyear {
    group_label: "Course Start Date"
    group_item_label: "Course Start Academic Term of Year"
    description: "e.g. Fall, Spring, etc. (independent of year)"
    }
  dimension: governmentdefinedacademictermyear {
    description: "August 1st to July 31st"
    group_label: "Course Start Date"
    group_item_label: "Course Start Academic Year"
    }
  dimension: day_of_term {
    group_label: "Course Start Date"
    group_item_label: "Course Start Day of Term"
  }
  dimension: week_of_term {
    group_label: "Course Start Date"
    group_item_label: "Course Start Week of Term"
  }
  dimension_group: datevalue {group_label: "Course Start Date"
    label: "Course Start"
    hidden: no
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      week_of_year,
      day_of_year
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]}

  dimension: date {
    description: "Course Start Date"
    group_label: "Course Start Date" }
  dimension: isweekendname {
    description: "Course started on weekend / weekday"
    group_label: "Course Start Date"
    group_item_label: "Course Start Is a Weekend"}

}

view: dim_app_usage_date {
  extends: [dim_date]
  label: "App Dock"
  dimension: fiscalyear {
    hidden: yes
#     sql: ${TABLE}.fiscalyearvalue
    group_label: "Usage Date"}
  dimension: governmentdefinedacademicterm {group_label: "Usage Date"}
  dimension: governmentdefinedacademictermofyear {group_label: "Usage Date"}
  dimension: governmentdefinedacademictermyear {group_label: "Usage Date"}
  dimension_group: datevalue {group_label: "Usage Date"
    hidden: no
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]}
  dimension: isweekendname {group_label: "Usage Date"}

}

view: dim_activation_date {
  extends: [dim_date]
  label: "Activations"

  dimension: fiscalyear {
    hidden: no
#     sql: ${TABLE}.fiscalyearvalue
    group_label: "Activation Date"}
  dimension: governmentdefinedacademicterm {group_label: "Activation Date"}
  dimension: governmentdefinedacademictermofyear {group_label: "Activation Date"}
  dimension: governmentdefinedacademictermyear {group_label: "Activation Date"}
  dimension_group: datevalue {group_label: "Activation Date"
    type: time
    hidden: no
    timeframes: [
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      day_of_year
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]}
  dimension: isweekendname {hidden:yes group_label: "Activation Date"}
}

view: dim_activity_date {
  extends: [dim_date]
  label: "Learning Path - Usage Data"

  dimension: fiscalyear {
    hidden: no
#     sql: ${TABLE}.fiscalyearvalue
    group_label: "Date of Activity"}
  dimension: governmentdefinedacademicterm {group_label: "Date of Activity"}
  dimension: governmentdefinedacademictermofyear {group_label: "Date of Activity"}
  dimension: governmentdefinedacademictermyear {group_label: "Date of Activity"}
  dimension_group: datevalue {group_label: "Date of Activity"
    type: time
    hidden: no
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      day_of_year
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]}
  dimension: isweekendname {hidden:yes group_label: "Date of Activity"}
}

view: dim_master_first_used_date {
  extends: [dim_date]
  dimension: governmentdefinedacademicterm { hidden:yes}
  dimension: governmentdefinedacademictermofyear {hidden: yes}
#   label: "Learning Path"


#   dimension: fiscalyear {hidden: no }
#   dimension: governmentdefinedacademicterm {group_label: "Master First Use Date"}
#   dimension: governmentdefinedacademictermofyear {group_label: "Master First Use Date"}
#   dimension: governmentdefinedacademictermyear {group_label: "Master First Use Date"}
#   dimension_group: datevalue {group_label: "Master First Use Date"
#     timeframes: [
#       date,
#       month,
#       month_name,
#       year,
#       fiscal_year,
# #       fiscal_quarter,
# #       fiscal_quarter_of_year,
# #       fiscal_month_num
#     ]}
  dimension: isweekendname {hidden: yes}

}

view: dim_end_date {
  extends: [dim_date]
#   label: "Date - Course End Date"
  label: "Course / Section Details"
  dimension: fiscalyear {
    hidden: no
#     sql: ${TABLE}.fiscalyearvalue
    group_label: "Course End Date"
    group_item_label:"Course End Fiscal Year"
  }
  dimension: governmentdefinedacademicterm {
    group_label: "Course End Date"
    group_item_label: "Course End Academic Term"
    description: "e.g. Fall 2019, Spring 2017, etc. (specific to year)"
  }
  dimension: governmentdefinedacademictermofyear {
    group_label: "Course End Date"
    group_item_label: "Course End Academic Term of Year"
    description: "e.g. Fall, Spring, etc. (independent of year)"
  }
  dimension: governmentdefinedacademictermyear {
    description: "August 1st to July 31st"
    group_label: "Course End Date"
    group_item_label: "Course End Academic Year"
  }
  dimension: day_of_term{
    group_label: "Course End Date"
    group_item_label: "Course End Day of Term"
  }
  dimension: week_of_term {
    group_label: "Course End Date"
    group_item_label: "Course End Week of Term"
  }
  dimension_group: datevalue {group_label: "Course End Date"
    label: "Course End"
    hidden: no
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      year,
      day_of_week,
      week_of_year
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]}

  dimension: date {
    description: "Course End Date"
    group_label: "Course End Date" }
}

view: dim_created_date {
  extends: [dim_date]
  label: "Date - Date Created"
}

view: dim_completion_date {
  extends: [dim_date]
  label: "Date - Date Completed"
}
