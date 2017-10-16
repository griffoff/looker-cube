view: activity_chapter_usage_facts {

    derived_table: {

      explore_source: fact_siteusage {
        column: chapter {field: mindtap_lp_activity_tags.chapter}
        column: activity_by_chapter { field: mindtap_lp_activity_tags.activity_by_chapter }
        column: no_of_unique_activities { field: dim_learningpath.lowest_level_count_distinct }
        column: courseid { field: dim_course.courseid }
        column: partyid { field: dim_party.partyid }
      }
      datagroup_trigger: fact_siteusage_datagroup
    }

    dimension: chapter {
      order_by_field: chapter_order
    }
    dimension: chapter_order {
      type: number
      sql: ${chapter} ;;
    }
    dimension: activity_by_chapter {}
    dimension: no_of_unique_activities {}
    dimension: courseid {}
    dimension: partyid {}


    dimension: activity_type_usage_bucket{
      label: "Student Usage Bucket"
      type: string
      case: {
        when: {
          sql: COALESCE(${no_of_unique_activities},0) = 0 ;;
          label: "0-Nousage"
        }
        when: {
          sql: ${no_of_unique_activities} = 1;;
          label: "One Time usage"
        }
        when: {
          sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_chapter} < 0.25 ;;
          label: "25%"
        }
        when: {
          sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_chapter} < 0.5 ;;
          label: "50%"
        }
        when: {
          sql: ${no_of_unique_activities}/${mindtap_lp_activity_tags.activity_by_chapter} < 0.75 ;;
          label: "75%"
        }
        else: "75%+"
      }



  }
  }
