- view: dim_location
  sql_table_name: DW_GA.DIM_LOCATION
  fields:

  - dimension: city
    type: string
    sql: ${TABLE}.CITY

  - dimension: country
    type: string
    sql: ${TABLE}.COUNTRY

  - dimension: countrycode
    type: string
    sql: ${TABLE}.COUNTRYCODE

  - dimension: dw_ldid
    type: string
    sql: ${TABLE}.DW_LDID

  - dimension_group: dw_ldts
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.DW_LDTS

  - dimension: latitude
    type: number
    sql: ${TABLE}.LATITUDE

  - dimension: locationid
    type: string
    # hidden: true
    sql: ${TABLE}.LOCATIONID

  - dimension: longitude
    type: number
    sql: ${TABLE}.LONGITUDE

  - dimension: postalcode
    type: string
    sql: ${TABLE}.POSTALCODE

  - dimension: region
    type: string
    sql: ${TABLE}.REGION

  - dimension: regioncode
    type: string
    sql: ${TABLE}.REGIONCODE

  - measure: count
    type: count
    drill_fields: [location.locationid]

