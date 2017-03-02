view: fact_activation_appusage {
  label: "App Dock"
  derived_table: {
    sql:
    select CourseId, PartyId, ProductId, ProductPlatformId,UserId
      ,sum(ClickCount) as Clicks
    from migration_test.dw_ga.fact_appusage
    group by 1, 2, 3, 4, 5
       ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: pk {
    type: string
    sql: ${TABLE}.COURSEID || ${TABLE}.USERID ;;
    hidden:  yes
    primary_key: yes
  }

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden:  yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden:  yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden:  yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden:  yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden:  yes
  }

  measure: user_count {
    label: "# Users"
    type:  count_distinct
    sql: ${userid} ;;
  }

  measure: app_usage_percent_of_activations{
    label: "app usage % of activations"
    type: number
    value_format_name: percent_1
    sql: ${user_count}/${fact_activation.user_count} ;;
  }
}
