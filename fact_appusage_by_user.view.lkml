view: course_apps {
  derived_table: {
    sql:
    select distinct iframeapplicationid, courseid
    from dw_ga.fact_appusage
    ;;
  }
}

view: fact_appusage_by_user {
  view_label: "App Dock"
  derived_table: {
#
#    This generates appclicks per user per course, for all apps ever used in that given course by any user
#
#     sql:
#       with app as (
#         select distinct courseid, a.iframeapplicationid, a.iframeapplicationid_group
#         from dw_ga.fact_appusage u
#         inner join ${dim_iframeapplication.SQL_TABLE_NAME} a on u.iframeapplicationid = a.iframeapplicationid
#         )
#       ,usage as (
#         select courseid, iframeapplicationid, userid, sum(clickcount) as clickcount
#         from dw_ga.fact_appusage
#         group by 1, 2, 3
#         )
#       select
#           u.userid || app.iframeapplicationid_group || act.courseid as pk
#           ,u.userid
#           ,app.iframeapplicationid_group as iframeapplicationid
#           ,act.courseid
#           ,sum(clickcount) as appclicks
#       FROM dw_ga.dim_user u
#       inner join dw_ga.fact_activation act on u.userid = act.userid
#       inner join app on act.courseid = app.courseid
#       left join usage a on (app.courseid, app.iframeapplicationid, u.userid) = (a.courseid, a.iframeapplicationid, a.userid)
#       group by 2,3,4
#       order by act.courseid, u.userid
# ;;

    create_process: {

      sql_step:
        use schema looker_scratch
        ;;
      sql_step:
          set min_date_key = (
            select min(datekey)
            from dw_ga.dim_date
            where datevalue > dateadd(month, -12, current_date())
            )
        ;;

      sql_step:
        create or replace temporary table app
        as
        select distinct courseid, a.iframeapplicationid, a.iframeapplicationid_group
        from dw_ga.fact_appusage u
        inner join ${dim_iframeapplication.SQL_TABLE_NAME} a on u.iframeapplicationid = a.iframeapplicationid
        where u.eventdatekey >= $min_date_key
        ;;

      sql_step:
        create or replace temporary table usage
        as
          select courseid, iframeapplicationid, userid, sum(clickcount) as clickcount
          from dw_ga.fact_appusage u
          where u.eventdatekey >= $min_date_key
          group by 1, 2, 3
        ;;

        sql_step:
          create or replace table ${SQL_TABLE_NAME}
          as
          select
              array_to_string(array_construct(act.userid, app.iframeapplicationid_group, act.courseid), '||') as pk
              ,act.courseid
              ,app.iframeapplicationid_group as iframeapplicationid
              ,act.userid
              ,sum(clickcount) as appclicks
          from dw_ga.fact_activation act
          inner join app on act.courseid = app.courseid
          left join usage a on (app.courseid, app.iframeapplicationid, act.userid) = (a.courseid, a.iframeapplicationid, a.userid)
          group by 2, 3, 4
          order by 2, 3, 4
        ;;
    }

      sql_trigger_value: select date_trunc(week, current_date());;
  }

  set: curated_fields_WL{ fields:[] }

  dimension: pk {
    hidden: yes
    sql: ${TABLE}.pk ;;
    primary_key: yes
  }

  dimension: userid {
    hidden: yes
    sql: ${TABLE}.userid ;;
  }

  dimension: iframeapplicationid {
    hidden: yes
    sql: ${TABLE}.iframeapplicationid ;;
  }

  dimension: courseid {
    hidden: yes
    sql: ${TABLE}.courseid ;;
  }

  dimension: appclicks_base {
    type: number
    sql: COALESCE(${TABLE}.appclicks, 0) ;;
    hidden: yes
  }

  dimension: appclick_bucket {
    label: "App usage buckets"
    type: tier
    style: integer
    tiers: [1, 2, 4, 8]
    sql: ${appclicks_base} ;;
  }

  measure: appclicks_avg {
    label: "Avg # Total app usage"
    description: "Average of Total no. of times a user used an app"
    type: average
    sql: ${appclicks_base} ;;
  }

  measure: user_count {
    label: "# of Users"
    description: "Number of unique users who have clicked on the app"
    type: count_distinct
    sql: case when ${appclicks_base} > 0 then ${userid} end ;;
    drill_fields: [dim_iframeapplication.displayname,dim_institution.institutionname,dim_course.is_lms_integrated,courseinstructor.instructorid,dim_course.count,fact_siteusage.percent_of_activations]
  }

}
