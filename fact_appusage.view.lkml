view: fact_appusage {
  label: "App Dock"
  derived_table: {
    sql: with r as (
        SELECT iframeapplicationid, DENSE_RANK() OVER (ORDER BY count(distinct userid) DESC) as rank
        FROM migration_test.dw_ga.FACT_APPUSAGE
        GROUP BY 1
      )
      select f.*, r.rank
      from dw_ga.fact_appusage f
      inner join r on f.iframeapplicationid = r.iframeapplicationid
          ;;
  }
  #sql_table_name: DW_GA.FACT_APPUSAGE ;;

  dimension:  pk {
    sql: ${TABLE}.pageinstanceid || ${TABLE}.eventdatekey || ${TABLE}.timekey || ${TABLE}.iframeapplicationid ;;
    hidden:  yes
    primary_key: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  measure: clickcount {
    label: "# of Clicks"
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
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: user_count {
    label: "# of Users"
    type: count_distinct
    sql: ${userid} ;;
  }

  #measure: appusage_percent_of_activations {
  #  label: "# app users % of activations "
  #  type: number
  #  sql:  ${user_count} / ${activations_totals.user_count} ;;
  #  value_format_name: percent_1
  #}

  filter: filter_appusage_rank {
    label: "Overall Rank - Filter"
    type: number
    default_value: "1 to 10"
    suggestions: ["1 to 5", "1 to 10"]
  }

  dimension: app_rank {
    label: "Overall Rank"
    description: "The overal rank of an app based on total usage"
    suggestions: ["1 to 5", "1 to 10"]
    type: number
    sql: ${TABLE}.RANK ;;
    can_filter: no
  }

  measure: count {
    type: count
    drill_fields: [location.locationid]
  }
}