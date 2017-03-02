view: dim_activationfilter {
  label: "Activations"
  sql_table_name: DW_GA.DIM_ACTIVATIONFILTER ;;

  dimension: activationfilterid {
    type: string
    sql: ${TABLE}.ACTIVATIONFILTERID ;;
    hidden: yes
  }

  dimension: activationfiltername {
    label: "Activation Filter"
    description: "Shows whether activation has entity/course relationshio directly from activation record, or has been matched downstream
    This filter should be used if you are trying to match back the activations dashboard"
    type: string
    sql: ${TABLE}.ACTIVATIONFILTERNAME ;;
  }

}
