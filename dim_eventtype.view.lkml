view: dim_eventtype {
  label: "Learning Path Modifications"
  sql_table_name: DW_GA.DIM_EVENTTYPE ;;



  measure: removed_count {
    label: "# Activities Removed"
    type: count
    filters: {
      field: eventtypename
      value: "Item Removed"
    }
  }

  measure: removed_from_course_count {
    view_label: "Learning Path"
    label: "# Courses where activity removed"
    type: count_distinct
    sql: ${dim_course.courseid} ;;
    filters: {
      field: eventtypename
      value: "Item Removed"
    }
  }

  measure: removed_from_activated_course_count {
    view_label: "Learning Path"
    label: "# Courses with activations where activity is unassigned"
    type: number
    sql: count( distinct case when ${eventtypename} = 'Item Removed' and ${fact_activation_by_course.noofactivations_base} > 0 then ${dim_course.courseid} end);;
  }

  measure: removed_from_course_user_count {
    hidden: yes
    view_label: "Learning Path"
    label: "# Activations for courses where activity is unassigned"
    type: sum_distinct
    #sql: case when ${eventtypename} = 'Item Removed' then ${fact_activation_by_course.noofactivations_base} end ;;
    sql: ${fact_activation_by_course.noofactivations_base} ;;
    sql_distinct_key: ${fact_activation_by_course.courseid} ;;
    filters:  {
      field: eventtypename
      value: "Item Removed"
    }
  }

  measure: removed_percent {
    label: "% Activities Removed"
    type: number
    sql: ${removed_count} / ${dim_activity.count} ;;
    value_format_name: percent_2
  }

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: eventtypename {
    label: "Action"
    type: string
    sql: ${TABLE}.EVENTTYPENAME ;;
  }

  dimension: is_removed {
    type: yesno
    sql: ${eventtypename} = 'Item Removed' ;;
  }

  dimension: major_changes {
    label: "Major Actions"
    type: string
    case: {
      when: {
        label: "Added"
        sql: ${eventtypename} = 'Item Added'  ;;
      }

      when: {
        label: "Removed"
        sql: ${eventtypename} = 'Item Removed'  ;;
       }
      else: "Unchanged"
    }
  }

}
