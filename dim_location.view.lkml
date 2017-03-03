view: dim_location {
  label: "Geography"
  sql_table_name: DW_GA.DIM_LOCATION ;;

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.COUNTRYCODE ;;
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
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: postalcode {
    label: "Postal/Zip code"
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.REGION ;;
  }

  dimension: regioncode {
    label: "Region code"
    type: string
    sql: ${TABLE}.REGIONCODE ;;
  }

  measure: count {
    label: "No. of locations"
    type: count
    drill_fields: [location.country, location.city, location.region]
  }
}