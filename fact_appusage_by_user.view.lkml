view: fact_appusage_by_user {
  view_label: "App Dock"
  derived_table: {
#
#     This generates appclicks per user per course, but only for people who have used an app
#
#     sql:
#       select
#           row_number() over (order by 2, 3, 4) as pk
#           ,p.partyid
#           ,app.iframeapplicationid
#           ,c.courseid
#           ,sum(clickcount) as appclicks
#       FROM dw_ga.dim_party p
#       cross join dw_ga.dim_iframeapplication app
#       cross join dw_ga.dim_course c
#       left join dw_ga.fact_appusage a on (c.courseid, p.partyid, app.iframeapplicationid) = (a.courseid, a.partyid, a.iframeapplicationid)
#       group by 2,3,4
#       ;;
#
#     This generates appclicks per user per course, for all apps ever used in that given course by any user
#
    sql:
      with app as (
        select distinct courseid, iframeapplicationid
        from dw_ga.fact_appusage
        )
      ,usage as (
        select courseid, iframeapplicationid, partyid, sum(clickcount) as clickcount
        from dw_ga.fact_appusage
        group by 1, 2, 3
        )
      select
          p.partyid || app.iframeapplicationid || act.courseid as pk
          ,p.partyid
          ,app.iframeapplicationid
          ,act.courseid
          ,sum(clickcount) as appclicks
      FROM dw_ga.dim_party p
      inner join dw_ga.fact_activation act on p.partyid = act.partyid
      inner join app on act.courseid = app.courseid
      left join usage a on (app.courseid, app.iframeapplicationid, p.partyid) = (a.courseid, a.iframeapplicationid, a.partyid)
      group by 2,3,4
;;

      sql_trigger_value: select count(*) from dw_ga.fact_appusage ;;
  }

  dimension: pk {
    hidden: yes
    sql: ${TABLE}.pk ;;
    primary_key: yes
  }

  dimension: partyid {
    hidden: yes
    sql: ${TABLE}.partyid ;;
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

}
