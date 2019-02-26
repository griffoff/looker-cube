view: user_activity_buckets {
  derived_table: {
    explore_source: fact_siteusage {
      column: userid {}
      column: courseid {}
      column: total_users {}
      column: count_eventdate {}
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
    sql: total_users ;;
    style: integer
    tiers: [2,5,10,20,30,40]
  }

  dimension: userid {
    hidden: yes
  }

  dimension: courseid {
    hidden: yes
  }
}
