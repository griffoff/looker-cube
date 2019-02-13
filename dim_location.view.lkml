view: dim_location {
  label: "Geography"
  sql_table_name: DW_GA.DIM_LOCATION ;;
  set: curated_fields {fields:[country,count]}

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
    hidden: yes
  }

  dimension: country {
    type: string
    label: "Geographical Country"
    description: "Country from where the product was accessed"
    sql: ${TABLE}.COUNTRY ;;
    hidden: no
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.COUNTRYCODE ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension_group: dw_ldts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.LATITUDE ;;
    hidden: yes
  }

  dimension: locationid {
    type: string
    hidden: yes
    sql: ${TABLE}.LOCATIONID ;;
    primary_key: yes
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.LONGITUDE ;;
    hidden: yes
  }

  dimension: location {
    group_label: "Location"
    label: "Coordinates"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: postalcode {
    group_label: "Location"
    label: "Postal/Zip code"
    type: string
    sql: ${TABLE}.POSTALCODE ;;
    hidden: yes
  }

  dimension: region {
    type: string
    sql: ${TABLE}.REGION ;;
    hidden: yes
  }

  dimension: regioncode {
    group_label: "Location"
    label: "Region code"
    type: string
    sql: ${TABLE}.REGIONCODE ;;
    map_layer_name: us_states
    #hidden: yes
  }

  measure: count {
    label: "# Locations"
    description: "No of locations for a Institution"
    type: count
    drill_fields: [location.country, location.city, location.region]
  }
}
