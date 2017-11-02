view: paid_users {
derived_table: {
  sql:
    select distinct courseid, userid
    from dw_ga.fact_activation;;
  sql_trigger_value: SELECT COUNT(*) FROM dw_ga.fact_activation  ;;
  }

  dimension: courseid {hidden:yes}
  dimension: userid {hidden:yes}
  dimension: paid {
    type: yesno
    sql: ${userid} is not null;;
    hidden: yes
  }

  dimension: paidcategory {
    label: "Paid (Paid/Unpaid)"
    type: string
    sql: case when ${userid} is not null then 'Paid' else 'Unpaid' end;;
  }
}

view: fact_siteusage {
  label: "Learning Path - Usage Data"
  #sql_table_name: DW_GA.FACT_SITEUSAGE ;;
  set:  curated_fields {
    fields: [percent_of_activations,percent_of_all_activations,session_count,usercount]
    }
  #sql_table_name: DW_GA.FACT_SITEUSAGE ;;
  derived_table: {
    sql:
      select
            coalesce(datediff(day, v.start_date, fsu.eventdate), daysfromcoursestart) as new_relative_days_from_start
            --,row_number() over (order by pageinstanceid, userid, learningpathid, eventdate, new_relative_days_from_start) as id
            ,looker_scratch.fact_siteusageid.nextval as id
            ,fsu.*
            ,CASE
              WHEN fsu.PAGEVIEWTIME>=1000
                THEN fsu.PAGEVIEWTIME /1000.0/86400.0
              END as pageviewtime_days
      from dw_ga.fact_siteusage fsu
      inner join dw_ga.dim_course c on fsu.courseid = c.courseid
      left join ${map_course_versions.SQL_TABLE_NAME} v on c.coursekey = v.context_id
                                                                  and fsu.eventdate between v.effective_from and v.effective_to
      order by courseid, new_relative_days_from_start, userid;;

      sql_trigger_value: select count(*) from dw_ga.fact_siteusage;;
  }

  dimension: pk {
    sql: ${TABLE}.id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: activityid {
    hidden: yes
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
  }

  measure: clickcount_avg {
    label: "Clicks (avg)"
    type: average
    sql: ${TABLE}.CLICKCOUNT ;;
    html:
    <div style="width:100%;">
      <div title="max: {{clickcount_avg_max._rendered_value}}" style="width: {{clickcount_avg_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
  }

  measure: clickcount_max {
    label: "Clicks (max)"
    type: number
    sql: max(${clickcount} ) over ();;
  }

  measure: clickcount_avg_max {
    label: "Clicks (avg) (max)"
    type: number
    sql: max(${clickcount_avg} ) over ();;
    hidden: yes
  }

  measure: clickcount_total_max {
    label: "Clicks (max) (max)"
    type: number
    sql: max(${clickcount}) over ();;
    hidden: yes
  }

  measure: clickcount_avg_percent {
    type: number
    sql: ${clickcount_avg_max}/${clickcount_avg_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: clickcount_percent {
    type: number
    sql: ${clickcount}/${clickcount_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: clickcount {
    label: "Clicks (total)"
    type: sum
    sql: ${TABLE}.CLICKCOUNT ;;
    html:
    <div style="width:100%;">
      <div title="max: {{clickcount_max._rendered_value}}" style="width: {{clickcount_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
  }

  dimension: courseenddatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEENDDATEKEY ;;
  }

  dimension: courseid {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: coursestartdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.COURSESTARTDATEKEY ;;
  }

  dimension: daysbeforecourseend {
    hidden: yes
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
  }

  dimension: daysfromcoursestart {
    hidden: yes
    type: string
    sql:${TABLE}.new_relative_days_from_start ;;
    #sql: ${TABLE}.DAYSFROMCOURSESTART ;;
  }

  dimension: deviceplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
  }

  dimension_group: eventdate {
    label: "Event Start"
    type: time
    timeframes: [time, hour, minute, date, week, month, raw]
    sql: ${TABLE}.EVENTDATE ;;
  }

  dimension_group: eventenddate {
    label: "Event End"
    type: time
    timeframes: [time, hour, minute, date, week, month, raw]
    sql: DATEADD(millisecond, ${pageviewtime}, ${TABLE}.EVENTDATE) ;;
  }

  dimension: eventdatekey {
    hidden: yes
    type: string
    sql: ${TABLE}.EVENTDATEKEY ;;
  }

  dimension: eventtypeid {
    hidden: yes
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
  }

  dimension: filterflag {
    hidden: yes
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
  }

  dimension: institutionid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
  }

  dimension: institutionlocationid {
    hidden: yes
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
  }

  dimension: learningpathid {
    hidden: yes
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
  }

  dimension_group: loaddate {
    hidden: yes
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
  }

  dimension: locationid {
    hidden: yes
    type: string
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: masternodeid {
    hidden: yes
    type: string
    sql: ${TABLE}.MASTERNODEID ;;
  }

  dimension: pagedomainid {
    hidden: yes
    type: string
    sql: ${TABLE}.PAGEDOMAINID ;;
  }

  dimension: pageinstanceid {
    hidden: yes
    type: string
    sql: ${TABLE}.PAGEINSTANCEID ;;
  }

  dimension: pageviewcount {
    type: number
    sql: ${TABLE}.PAGEVIEWCOUNT ;;
    hidden: yes
  }

  measure: pageviewcount_avg {
    label: "Views (avg)"
    type: average
    sql: ${pageviewcount} ;;
    hidden: yes
  }

  measure: pageviewcount_sum {
    label: "Views (total)"
    type: sum
    sql: ${pageviewcount} ;;
    hidden: yes
  }

  dimension: pageviewtime {
    type: number
    sql: ${TABLE}.PageViewTime_days;;
    hidden: yes
  }

  measure: pageviewtime_max {
    group_label: "Time in product"
    label: "Time in product (max time per page)"
    type: max
    sql: ${pageviewtime};;
    value_format_name: duration_hms
  }

  measure: pageviewtime_avg {
    group_label: "Time in product"
    label: "Time in product (avg time per page)"
    type: average
    sql: ${pageviewtime};;
    value_format_name: duration_hms
    html:
    <div style="width:100%;">
      <div title="max: {{pageviewtime_max._rendered_value}}" style="width: {{pageviewtime_percent._rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">
        {{rendered_value}}
      </div>
    </div>;;
  }

  measure: pageviewtime_dailyaverage {
    group_label: "Time in product"
    label: "Time in product (daily avg per student)"
    type: number
    sql: ${pageviewtime_sum} / nullif(${usercount}, 0) / nullif(${daycount}, 0);;
    value_format_name: duration_hms
  }

  measure: pageviewtime_useraverage {
    group_label: "Time in product"
    label: "Time in Mindtap (avg per student)"
    type: number
    sql: ${pageviewtime_sum} / nullif(${usercount}, 0);;
    value_format: "d \d\a\y\s h \h\r\s m \m\i\n\s"
  }

  measure: daycount {
    hidden: yes
    type: count_distinct
    sql: ${eventdate_date} ;;
  }

  measure: pageviewtime_percent {
    type: number
    sql: ${pageviewtime_avg}/${pageviewtime_max} ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: pageviewtime_sum {
    group_label: "Time in product"
    label: "Time in product (total) days:hours:min:sec"
    type: sum
    sql: ${pageviewtime} ;;
#     value_format: "d:hh:mm:ss"
    value_format: "d \d\a\y\s h \h\r\s m \m\i\n\s"
  }

  measure: pageviewtime_sum_hours {
    label: "Browser time (total hours)"
    description: "Total browser time in hours"
    type: sum
    hidden:  yes
    sql: ${pageviewtime}*24 ;;
# Note: I created this measure to report the number of hours. The formatting for the original measure caused errors as it does not format for time duration and tries to format it like time on a clock. -CM
  }

  measure: session_count {
    label: "# Sessions"
    type: count_distinct
    sql: ${TABLE}.sessionnumber ;;
    value_format: "#,##0"
    hidden: yes
  }

  dimension: partyid {
    hidden: yes
    type: string
    sql: ${TABLE}.PARTYID ;;
  }

  dimension: productid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTID ;;
  }

  dimension: productplatformid {
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
  }

  dimension: timekey {
    hidden: yes
    type: string
    sql: ${TABLE}.TIMEKEY ;;
  }

  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.USERID ;;
  }

  measure: usercount {
    label: "# Users (Distinct)"
    description: "This is the number of unique users that have activity related to the current context
    NOTE: The total # Users will most likely be different from the sum of # Users at a lower level (for example: at chapter level).
          This is because the same user can use each chapter and so will be counted in the # Users at chapter level,
          if there are 10 chapters and the user visited every chapter, the sum total would be 10, but the total # Users is just 1."
    type: count_distinct
    sql: ${partyid} ;;
    hidden: no
#     drill_fields: [dim_product.productfamily, dim_institution.institutionname, mindtap_lp_activity_tags.chapter, mindtap_lp_activity_tags.learning_path_activity_title, usercount, percent_of_activations]

#     drill_fields: [mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title_count]
#     drill_fields: [mindtap_lp_activity_tags.chapter,mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title,percent_of_activations]
    drill_fields: [partyid,mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title_count_fordrilldowns,fact_activityoutcome.score_avg,user_facts.logins_from_session_number,pageviewtime_useraverage]


  }

  measure: total_users {
  label: "# Users (Total)"
  description: "Total number of people who clicked on an item"
  type: count
  sql: ${partyid} ;;
  }

  measure: percent_of_activations {
    label: "% of Activations (used / exposed)"
    description: "
    No. of people / Total activations in this context
    i.e.
      no. of people who accessed vs no. of people who were exposed to this feature
    "
    type: number
    sql: COALESCE(${usercount} / NULLIF(${course_section_facts.total_noofactivations}, 0.0),0) ;;
    value_format_name: percent_1
    html:
      <div style="width:100%;">
        <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>
    ;;
    drill_fields: [dim_institution.institutionname,percent_of_activations]
  }

  measure: percent_of_all_activations {
    label: "% of Activations (used / all activations)"
    description: "
    No. of people who accessed vs. all activations/user possible whether they where exposed or whether the activity/item was hidden in their learning path"
    type:  number
    sql: COALESCE(${usercount} / NULLIF(${product_facts.activations_for_isbn}, 0.0),0) ;;
    value_format_name: percent_1
    html:
      <div style="width:100%;">
        <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>
    ;;
  }

  measure: time_on_task_to_final_score_correlation {
    label: "Time spent in activity to MindTap overall score correlation"
    type: number
    sql: CORR(${user_final_scores.final_score}, ${pageviewtime}) ;;
    value_format_name: decimal_3
  }

  measure: time_on_task_to_final_score_correlation_rank_by_product_family {
    label: "Time spent in activity to MindTap overall score correlation rank by product family"
    type: number
    sql: dense_rank() over (partition by ${dim_product.discipline}, ${dim_product.productfamily_edition} order by coalesce(${time_on_task_to_final_score_correlation}, 0) desc)  ;;
    value_format_name: decimal_0
    required_fields: [dim_product.discipline, dim_product.productfamily_edition]
    can_filter: no
  }
}
#- measure: count
#  label: 'No. of page view records'
#  type: count
#  drill_fields: [location.locationid]
