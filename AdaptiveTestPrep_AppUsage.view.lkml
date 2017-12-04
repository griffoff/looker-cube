view: adaptivetestprep_appusage {
derived_table: {
  sql: Select di.IFRAMEAPPLICATIONNAME
              ,dd.datevalue, dp.authors, dp.discipline,
              fa.clickcount, partyid
              from dw_ga.Fact_appusage FA
              join dw_ga.dim_iframeapplication DI
              on FA.iframeapplicationid = DI.iframeapplicationID
              and fa.iframeapplicationid in(2170,49,584,588,526)
              join dw_ga.dim_product dp
              on fa.productid = dp.productid
              join dw_ga.dim_date dd
              on dd.datekey = fa.eventdatekey;;
              }


   dimension: MindApp {
    description: "The Mind App name "
    type: string
    sql: ${TABLE}.IFRAMEAPPLICATIONNAME ;;
   }

  dimension: EventDate{
    description: "The date the usage occurred"
    type: date
    sql: ${TABLE}.datevalue ;;
    }

  dimension: EventMonth{
    description: "The month the usage occurred"
    type: date_month
    sql: ${TABLE}.datevalue ;;
  }

  dimension: EventYear{
    description: "The year the usage occurred"
    type: date_year
    sql: ${TABLE}.datevalue ;;
  }

  dimension: Author{
    description: "Author name"
    type: string
    sql: ${TABLE}.authors ;;
  }

  dimension: HED{
    description: "Higher Education Discipline name"
    type: string
    sql: ${TABLE}.discipline ;;
  }

  measure: App_Clicks{
   description: "The number of clicks on the app"
   type: sum
   sql: ${TABLE}.clickcount;;
  }


  measure: AppUsers{
    description: "The count of users accessing the app"
    type: count_distinct
    sql: ${TABLE}.partyid;;
  }

#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
