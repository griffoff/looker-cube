view: user_activity_buckets {
  derived_table: {
    explore_source: fact_siteusage {
      column: userid {}
      column: courseid {}
      column: total_users {}
      column: count_eventdate {}
      column: relative_weeks {field:dim_relative_to_start_date.weeksname}
    }
  }

  dimension: clicks_bucket{
    type: tier
    label: "Usage Tiers"
    sql: total_users ;;
    style: classic
    tiers: [0,10,20,30,40]
  }

  dimension: loggedin_bucket{
    type: tier
    label: "Logged In Tiers"
    sql: count_eventdate ;;
    style: integer
    tiers: [1,3,5,7]
  }

  dimension: userid {
    hidden: yes
  }

  dimension: courseid {
    hidden: yes
  }

  dimension: relative_weeks {
    type: number
  }
}
