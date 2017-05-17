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
