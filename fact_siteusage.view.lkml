include: "//core/access_grants_file.view"
include: "//core/named_formats.lkml"

view: paid_users {
derived_table: {
  sql:
    select distinct courseid, userid,cu_flg
      from ${fact_activation.SQL_TABLE_NAME};;
  sql_trigger_value: SELECT COUNT(*) FROM dw_ga.fact_activation  ;;
  }

  dimension: courseid {hidden:yes}
  dimension: userid {hidden:yes}
  dimension: paid {
    type: yesno
    sql: ${userid} is not null;;
    hidden: yes
  }

  set:  curated_fields{
    fields: [cu_user,paidcategory]
  }

  dimension: cu_user {
    label: "CU user flag"
    type: string
    sql: CASE WHEN ${TABLE}.cu_flg ilike 'Y' THEN 'CU User' ELSE 'Non CU user' END ;;
    description: "data field to identify CU vs Non CU users based on the activations feed"
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
    fields: [percent_of_activations,percent_of_all_activations,session_count,usercount,sourcedata]
    }
  set:  curated_fields_for_instructor_mod{
    fields: [session_count,usercount]
  }

  set: wl_fields {
    fields: [usercount,total_users]
  }

  set: events {
    fields: [session_number, eventdate_time, pageviewtime, pageviewcount, session_activity_count, clickcount,sourcedata]
  }

  #sql_table_name: DW_GA.FACT_SITEUSAGE ;;
  derived_table: {
    create_process: {
      sql_step:
        create transient table if not exists looker_scratch.fact_siteusage
        cluster by (courseid)
        as
        select
          null::int as new_relative_days_from_start
          --,row_number() over (order by pageinstanceid, userid, learningpathid, eventdate, new_relative_days_from_start) as id
          ,null::int as id
          ,fsu.*
          ,null::decimal(10, 6) as pageviewtime_days
          --,LAG(fsu.eventdate) over (partition by fsu.userid, fsu.productid, a.applicationname order by fsu.eventdate)
          ,null as prev_applicationusagedate
          ,null AS activity_sequence_day
          ,null AS activity_sequence_week
          ,null AS activity_sequence_week2
          ,null AS activity_sequence_week4
        from dw_ga.fact_siteusage fsu
        limit 0
      ;;


      sql_step:
        insert into looker_scratch.fact_siteusage
        select
          coalesce(datediff(day, v.start_date, fsu.eventdate), daysfromcoursestart) as new_relative_days_from_start
          --,row_number() over (order by pageinstanceid, userid, learningpathid, eventdate, new_relative_days_from_start) as id
          ,looker_scratch.fact_siteusageid.nextval as id
          ,fsu.*
          ,CASE
          WHEN fsu.PAGEVIEWTIME>=1000
          THEN fsu.PAGEVIEWTIME /1000.0/86400.0
          END as pageviewtime_days
          --,LAG(fsu.eventdate) over (partition by fsu.userid, fsu.productid, a.applicationname order by fsu.eventdate)
          ,null as prev_applicationusagedate
          --,DENSE_RANK() OVER (PARTITION BY fsu.userid, fsu.courseid, fsu.learningpathid ORDER BY fsu.eventdate::DATE)
          ,null AS activity_sequence_day
          --,DENSE_RANK() OVER (PARTITION BY fsu.userid, fsu.courseid, fsu.learningpathid ORDER BY floor(new_relative_days_from_start / 7))
          ,null AS activity_sequence_week
          --,DENSE_RANK() OVER (PARTITION BY fsu.userid, fsu.courseid, fsu.learningpathid ORDER BY floor(new_relative_days_from_start / 14))
          ,null AS activity_sequence_week2
          --,DENSE_RANK() OVER (PARTITION BY fsu.userid, fsu.courseid, fsu.learningpathid ORDER BY floor(new_relative_days_from_start / 28))
          ,null AS activity_sequence_week4
        from dw_ga.fact_siteusage fsu
        inner join dw_ga.dim_course c on fsu.courseid = c.courseid
        left join ${map_course_versions.SQL_TABLE_NAME} v on c.coursekey = v.context_id
                                                          and fsu.eventdate between v.effective_from and v.effective_to
        left join ${dim_activity.SQL_TABLE_NAME} a on fsu.activityid = a.activityid
        where eventdate > (select coalesce(max(eventdate), '1970-01-01') from looker_scratch.fact_siteusage)
        order by courseid
          --, new_relative_days_from_start, userid
        ;;

        sql_step: create or replace transient table ${SQL_TABLE_NAME} clone looker_scratch.fact_siteusage
        ;;

    }

    sql_trigger_value: select count(*) from dw_ga.fact_siteusage;;
  }

  dimension: prev_applicationusagedate {
    hidden: yes
  }

  measure: app_firstusage {
    label: "First Time Application Usage"
    description: "Count of unique users per isbn / course section who have used an application for the first time.
    n.b. Must be filtered or sliced by activity application "
    type: count_distinct
    sql: case when ${prev_applicationusagedate} is null then array_construct(${userid}, ${productid}, ${courseid}) end ;;
  }

  dimension: pk {
    label: "Primary Key"
    sql: ${TABLE}.id ;;
    hidden: no
    primary_key: yes
    required_access_grants: [can_view_cube_dev]
  }

  dimension: activityid {
    hidden: no
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
  }

  dimension: eventactionid {
    hidden: yes
    type: string
    sql: ${TABLE}.eventactionid ;;
  }

  dimension: sourcedata {
    hidden: no
    type: string
    sql: ${TABLE}.sourcedata  ;;
  }

  dimension: activity_sequence_day {hidden:yes}
  dimension: activity_sequence_week {
    label: "Weeks visited"
    description: "How many times has this activity been visited by a student (revisit is counted if the activity is opened in a different week)"
    type:tier
    tiers: [1, 2, 3]
    value_format: "\V\i\s\i\t 0"
    style: integer
    sql: CASE WHEN ${learningpathid} = -1 THEN NULL ELSE ${TABLE}.activity_sequence_week END ;;
    }

  dimension: activity_sequence_week2 {
    label: "Weeks visited 2"
    description: "How many times has this activity been visited by a student (revisit is counted if the activity is opened in a different 2 week section of the course)"
    type:tier
    tiers: [1, 2, 3]
    value_format: "\V\i\s\i\t 0"
    style: integer
    sql: CASE WHEN ${learningpathid} = -1 THEN NULL ELSE ${TABLE}.activity_sequence_week2 END ;;
  }

  dimension: activity_sequence_week4 {
    label: "Weeks visited 4"
    description: "How many times has this activity been visited by a student (revisit is counted if the activity is opened in a different 4 week section of the course)"
    type:tier
    tiers: [1, 2, 3]
    value_format: "\V\i\s\i\t 0"
    style: integer
    sql: CASE WHEN ${learningpathid} = -1 THEN NULL ELSE ${TABLE}.activity_sequence_week4 END ;;
  }

  measure: clickcount_avg {
    label: "Clicks (avg)"
    description: "Average number of clicks in the product"
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
    hidden: yes
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
    description: "Total number of clicks in the product"
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
    group_label: "Date of Activity"
    label: "Event Time"
    type: time
    hidden: no
    timeframes: [raw, time, hour, minute, date, week, month, quarter, quarter_of_year]
    sql: ${TABLE}.EVENTDATE ;;
  }

  measure: count_eventdate {
    label: "# days logged in"
    sql: COUNT(DISTINCT ${eventdatekey});;
    type: number
  }

  dimension: eventdatetimeStamp {
#     group_label: "Date of Activity"
    label: "Event Timestamp"
    type: date_second
    sql: ${TABLE}.EVENTDATE ;;
  }

  dimension: eventhour {
    label: "Hour event occured"
    type: date_hour_of_day
    sql: ${TABLE}.EVENTDATE ;;
  }
  measure: firsteventdate {
    label: "First Event Date"
    type: date_time
    sql:  MIN(${TABLE}.EVENTDATE);;
  }

  measure: firsteventmonth {
    label: "First Event Month"
    type: date_month
    sql:  MIN(${TABLE}.EVENTDATE);;
  }

  measure: lasteventdate {
    label: "Last Event Date"
    type: date_time
    sql:  MAX(${TABLE}.EVENTDATE);;
  }

  measure: ftc_timestamp {
    label: "EST Timezone Last Event Date"
    type: string
    sql: TO_CHAR(MAX(convert_timezone('EST',${TABLE}.EVENTDATE)),'YYYY/DD/MM HH24:MI:SS') ;;
  }

  dimension_group: eventenddate {
    label: "Event End"
    type: time
    hidden: yes
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
    value_format_name: duration_hms
  }

  measure: pageviewtime_max {
    group_label: "Time in product"
    label: "Time in product (max time per screen)"
    type: max
    sql: ${pageviewtime};;
    value_format_name: duration_hms
  }

  measure: pageviewtime_avg {
    group_label: "Time in product"
    label: "Time in product (avg time per screen)"
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

  measure: sessionviewtime_avg {
    group_label: "Time in product"
    label: "Time in product (avg time per session)"
    type: number
    sql: ${pageviewtime_sum} / nullif(${session_count}, 0);;
    value_format_name: duration_hms
  }

  measure: activityviewtime_avg {
    group_label: "Time in product"
    label: "Time in product (avg time per activity per session)"
    type: number
    sql: ${pageviewtime_sum} / nullif(${session_activity_count}, 0);;
    value_format_name: duration_hms
  }

  measure: pageviewtime_dailyaverage {
    group_label: "Time in product"
    label: "Time in product (daily avg per person per course)"
    type: number
    sql:  ${pageviewtime_sum} / nullif(${usercoursedaycount}, 0) ;;
    value_format_name: duration_hms
  }

  measure: activityviewtime {
    group_label: "Time in product"
    label: "Time in Activity"
    type: number
    sql: ${pageviewtime_sum};;
    value_format_name: duration_hms
    required_access_grants: [can_view_cube_dev]
  }

#   measure: pageviewtime_dailyaverage_by_student {
#     group_label: "Time in product"
#     label: "Time in product (avg time per page)"
#     type: number
#     sql: sum(${pageviewtime}) over (partition by ${userid}) / count(distinct ${eventdate_date}) over (partition by ${userid});;
#     value_format_name: duration_hms
#     hidden: yes
#   }
#
#   dimension: pageview_time_daily_tier {
#     label: "Time in product (daily avg per student)"
#     group_label: "Time in product"
#     type: tier
#     style: relational
#     tiers: [0.04166666667,  0.08333333333,  0.2083333333]
#     sql: ${pageviewtime_dailyaverage_by_student} ;;
#     value_format_name: duration_hms
#   }

  measure: pageviewtime_useraverage {
    group_label: "Time in product"
    label: "Time in Mindtap (avg per person per course)"
    type: number
    sql: ${pageviewtime_sum} / nullif(${usercoursecount}, 0);;
    value_format: "h \h\r\s m \m\i\n\s s \s\e\c\s"
    drill_fields: [events*]
  }

  measure: pageviewtime_percent {
    type: number
    sql: ${pageviewtime_avg}/nullif(${pageviewtime_max}, 0) ;;
    value_format_name: percent_1
    hidden:  yes
  }

  measure: pageviewtime_sum {
    group_label: "Time in product"
    label: "Time in product (total) days:hours:min:sec"
    type: sum
    sql: ${pageviewtime} ;;
#     value_format: "d:hh:mm:ss"
    value_format_name: duration_hms_full
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
    sql: ${session_number} ;;
    value_format: "#,##0"
    hidden: yes
  }

  measure: session_activity_count {
    label: "# Activities"
    type: count_distinct
    sql: array_construct(${session_number}, ${activityid}) ;;
    value_format: "#,##0"
    hidden: yes
  }

  measure: activity_count {
    label: "# Activities"
    type: count_distinct
    sql:  ${learningpathid} ;;
    value_format: "#,##0"
    hidden: no
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

  measure: daycount {
    hidden: yes
    type: count_distinct
    #sql: ${eventdate_date} ;;
    sql: ${dim_relative_to_start_date.days} ;;
  }

  measure: coursecount {
    type: count_distinct
    sql: ${courseid} ;;
    hidden: yes
  }

  measure: usercoursecount {
    type: count_distinct
    sql: HASH(${courseid}, ${userid}) ;;
    hidden:  yes
  }

  measure: usercoursedaycount {
    type: count_distinct
    sql: HASH(${courseid}, ${userid}, ${dim_relative_to_start_date.days}) ;;
    hidden:  yes
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
  measure: usercount_for_partnership{
    label: "# Unique Users"
    description: "This is the number of unique users that have activity related to the current context
    NOTE: The total # Users will most likely be different from the sum of # Users at a lower level (for example: at chapter level).
    This is because the same user can use each chapter and so will be counted in the # Users at chapter level,
    if there are 10 chapters and the user visited every chapter, the sum total would be 10, but the total # Users is just 1."
    type: count_distinct
    sql: ${partyid} ;;
    hidden: yes
#     drill_fields: [dim_product.productfamily, dim_institution.institutionname, mindtap_lp_activity_tags.chapter, mindtap_lp_activity_tags.learning_path_activity_title, usercount, percent_of_activations]

#     drill_fields: [mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title_count]
#     drill_fields: [mindtap_lp_activity_tags.chapter,mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title,percent_of_activations]
    drill_fields: [partyid,mindtap_lp_activity_tags.activity_type,mindtap_lp_activity_tags.learning_path_activity_title_count_fordrilldowns,fact_activityoutcome.score_avg,user_facts.logins_from_session_number,pageviewtime_useraverage]


  }




  measure: total_users {
  label: "# Users (Total Clicked)"
  description: "Total number of people who clicked on an item"
  type: number
  sql: count(${partyid}) ;;
  }

  measure: total_users_partnership {
    label: "# Total Clicks"
    description: "Total number of people who clicked on an item"
    type: number
    sql: count(${partyid}) ;;
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
    hidden: no
  }

  measure: time_on_task_to_final_score_correlation_rank_by_product_family {
    label: "Time spent in activity to MindTap overall score correlation rank by product family"
    type: number
    sql: dense_rank() over (partition by ${dim_product.discipline}, ${dim_product.productfamily_edition} order by coalesce(${time_on_task_to_final_score_correlation}, 0) desc)  ;;
    value_format_name: decimal_0
    required_fields: [dim_product.discipline, dim_product.productfamily_edition]
    can_filter: no
    hidden: yes
  }

  dimension: session_number {
    label: "Session Number"
    sql: ${TABLE}.SESSIONNUMBER ;;
  }

  measure: count_session {
    label: "# Sessions"
    type: count_distinct
    sql: ${TABLE}.SESSIONNUMBER ;;
  }
}
#- measure: count
#  label: 'No. of page view records'
#  type: count
#  drill_fields: [location.locationid]
