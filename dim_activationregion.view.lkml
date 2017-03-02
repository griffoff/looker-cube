view: dim_activationregion {
  label: "Activations"
  sql_table_name: DW_GA.DIM_ACTIVATIONREGION ;;

  dimension: activationregionid {
    type: string
    sql: ${TABLE}.ACTIVATIONREGIONID ;;
    hidden: yes
  }

  dimension: activationregionname {
    label: "Activation Region"
    description: "This is the region stamped on the activation record, which may not be the same as the location of the institution
    This filter should used when comparing to the activations dashboard"
    type: string
    sql: ${TABLE}.ACTIVATIONREGIONNAME ;;
  }

}
