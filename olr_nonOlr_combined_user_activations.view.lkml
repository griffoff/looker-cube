view: olr_nonolr_combined_user_activations {
    derived_table: {
      explore_source: fact_activation {
        column: user_guid {}
        column: activationsreportplatform { field: dim_productplatform.activationsreportplatform }
        column: total_noofactivations {}
        filters: {
          field: fact_activation.cu_flg
          value: "Y"
        }
      }
    }
    dimension: user_guid {
      label: "Activations User Guid"
      description: "User SSO GUID from the activations feed"
    }
    dimension: activationsreportplatform {
      label: "Product Platform in Activations Report"
    }
    dimension: total_noofactivations {
      label: "Activations Total Activations"
      description: "Represents the total number of activations associated with the query structure set up in Looker and the selected filtering criteria.
      Example: if you set up Looker to look at completed learning path activities, the measure 'Total Activations' will indicated how many accounts completed a given activity
      and NOT how many accounts 'saw' or could have completed a given activity.
      Meaning, 'Total Activations' cannot be used as a denominator for any '% of activation' calculations."
      type: number
    }

dimension: unique_product_buckets {
  type:  tier
  tiers: [ 2, 3, 4, 5]
  style:  integer
  sql:  ${total_noofactivations} ;;
}

measure: count_users {
  type:  count_distinct
  sql: ${user_guid} ;;
}
  }
