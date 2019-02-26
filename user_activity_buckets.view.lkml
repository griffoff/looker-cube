view: user_activity_buckets {
  derived_table: {
    explore_source: fact_siteusage {
      column: userid {}
      column: courseid {}
      column: total_users {}
    }
  }

  dimension: clicks_bucket{
    type: tier
    label: "Usage Tiers"
    sql: total_users ;;
    style: classic
    tiers: [0,10,20,30,40]
  }

  dimension: userid {
    hidden: yes
  }

  dimension: courseid {
    hidden: yes
  }
}
