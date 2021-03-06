view: fact_appusage {
  label: "App Dock"
  derived_table: {
    sql:
      with r as (
        SELECT a.bestdisplayname
              ,DENSE_RANK() OVER (ORDER BY sum(CASE WHEN f.eventdatekey >= to_char(dateadd(YEAR, -1, CURRENT_DATE), 'yyyymmdd')::int THEN CLICKCOUNT END)  DESC) as clickrank
              ,DENSE_RANK() OVER (ORDER BY count(distinct CASE WHEN f.eventdatekey >= to_char(dateadd(YEAR, -1, CURRENT_DATE), 'yyyymmdd')::int THEN userid END)  DESC) as userrank
        FROM dw_ga.FACT_APPUSAGE f
        inner join ${dim_iframeapplication.SQL_TABLE_NAME} a on  f.iframeapplicationid = a.iframeapplicationid
        --INNER JOIN dw_ga.dim_date ON f.eventdatekey = dim_date.datekey
        --where dim_date.fiscalyearvalue = 'FY18'
         --where f.eventdatekey >= to_char(dateadd(YEAR, -1, CURRENT_DATE), 'yyyymmdd')::int
        GROUP BY 1
      )
      ,r2 AS (
        SELECT a.iframeapplicationid, r.clickrank, r.userrank
        FROM r
        INNER JOIN ${dim_iframeapplication.SQL_TABLE_NAME} a ON r.bestdisplayname = a.bestdisplayname
      )
      select f.*, r2.clickrank, r2.userrank
      ,LAG(f.eventdatekey) over (partition by f.userid,f.productid,f.iframeapplicationid order by f.eventdatekey) as prev_applicationusagedate
      from dw_ga.fact_appusage f
      inner join r2 on f.iframeapplicationid = r2.iframeapplicationid
      order by f.courseid, f.userid, f.iframeapplicationid
          ;;
      sql_trigger_value: select count(*) from dw_ga.fact_appusage ;;
  }
  #sql_table_name: DW_GA.FACT_APPUSAGE ;;
  set: curated_fields_WL {fields:[]}
  dimension:  pk {
#     sql: ${TABLE}.pageinstanceid || ${TABLE}.eventdatekey || ${TABLE}.timekey || ${TABLE}.iframeapplicationid ;;
    sql: pageinstanceid || ${TABLE}.eventdatekey || ${TABLE}.timekey
    || ${TABLE}.iframeapplicationid || ${TABLE}.EVENTACTIONID
          || ${TABLE}.learningpathid || ${TABLE}.activityid || ${TABLE}.sourcedata || ${TABLE}.partyid ;;
    hidden:  yes
    primary_key: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: prev_applicationusagedate {
    hidden: yes
  }

  measure: app_firstusage {
    label: "First Time Application Usage in the App Dock"
    description: "Count of unique users per isbn / course section who have used an application for the first time.
    n.b. Must be filtered or sliced by app dock display name "
    type: count_distinct
    sql: case when ${prev_applicationusagedate} is null then array_construct(${userid}) end ;;
  }


  measure: clickcount {
    label: "# of Clicks"
    description: "Total Number of clicks on the App"
    type: sum
    sql: ${TABLE}.CLICKCOUNT ;;
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: deviceplatformid {
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: eventdatekey {
    type: string
    sql: ${TABLE}.EVENTDATEKEY ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: iframeapplicationid {
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONID ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension_group: loaddate {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: locationid {
    type: string
    hidden: yes
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: pageinstanceid {
    type: string
    sql: ${TABLE}.PAGEINSTANCEID ;;
    hidden: yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
  }

  dimension: timekey {
    label: "Time of Day"
    type: string
    sql: ${TABLE}.TIMEKEY;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  dimension:click_per_user_buckets {
    type: tier
    tiers: [2,5,9]
    style: relational
    sql: ${TABLE}.clickcount ;;
  }

  measure: user_count {
    label: "# of Users"
    type: count_distinct
    sql: ${userid} ;;
    hidden: yes
    drill_fields: [dim_iframeapplication.displayname,dim_institution.institutionname,dim_course.is_lms_integrated,courseinstructor.instructorid,dim_course.count,fact_siteusage.percent_of_activations]
  }

  #measure: appusage_percent_of_activations {
  #  label: "# app users % of activations "
  #  type: number
  #  sql:  ${user_count} / ${activations_totals.user_count} ;;
  #  value_format_name: percent_1
  #}

  filter: filter_appusage_rank {
    label: "Overall Click Rank - Filter"
    type: number
    default_value: "1 to 10"
    suggestions: ["1 to 5", "1 to 10"]
  }

  filter: filter_appusage_rank_user {
    label: "Overall User Rank - Filter"
    type: number
    default_value: "1 to 10"
    suggestions: ["1 to 5", "1 to 10"]
  }

  dimension: app_rank {
    label: "Overall Rank (by Total Clicks)"
    description: "The overal rank of an app based on total clicks"
    suggestions: ["1 to 5", "1 to 10"]
    type: number
    sql: ${TABLE}.CLICKRANK ;;
    can_filter: no
  }

  dimension: app_rank_user {
    label: "Overall Rank (by # Users)"
    description: "The overal rank of an app based on # users"
    suggestions: ["1 to 5", "1 to 10"]
    type: number
    sql: ${TABLE}.USERRANK ;;
    can_filter: no
  }

#   measure: count {
#     type: count
#     drill_fields: [location.locationid]
#   }
}
