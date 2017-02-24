view: location {
  sql_table_name: DW_GA.LOCATION ;;

  dimension: locationid {
    primary_key: yes
    type: string
    sql: ${TABLE}.LOCATIONID ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.COUNTRYCODE ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.REGION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      locationid,
      dim_location.count,
      fact_appusage.count,
      fact_session.count,
      fact_siteusage.count,
      fact_siteusage_v.count,
      institution_mapping.count,
      institution_temp.count
    ]
  }
}
