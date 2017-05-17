view: dim_deviceplatform {
  label: "Device/Platform"
  sql_table_name: DW_GA.DIM_DEVICEPLATFORM ;;

  dimension: devicebrowsergroup {
    group_label: "Browser"
    label: "Browser group"
    type: string
    sql: ${TABLE}.DEVICEBROWSERGROUP ;;
  }

  dimension: devicebrowsername {
    group_label: "Browser"
    label: "Browser name"
    type: string
    sql: ${TABLE}.DEVICEBROWSERNAME ;;
  }

  dimension: devicebrowserversion {
    group_label: "Browser"
    label: "Browser version"
    type: string
    sql: ${TABLE}.DEVICEBROWSERVERSION ;;
  }

  dimension: devicecategory {
    label: "Device category"
    description: "e.g. Desktop/Mobile/Tablet"
    group_label: "Device"
    type: string
    sql: ${TABLE}.DEVICECATEGORY ;;
  }

  dimension: deviceplatformgroup {
    label: "Device platform group"
    description: "Operating system"
    group_label: "Device"
    type: string
    sql: ${TABLE}.DEVICEPLATFORMGROUP ;;
  }

  dimension: deviceplatformid {
    type: string
    sql: ${TABLE}.DEVICEPLATFORMID ;;
    hidden: yes
  }

  dimension: deviceplatformname {
    label: "Device platform"
    description: "Operating system (version)"
    group_label: "Device"
    type: string
    sql: ${TABLE}.DEVICEPLATFORMNAME ;;
  }

  dimension: devicesystemname {
    label: "Device brand"
    description: "Apple/Lenovo/Dell/etc."
    group_label: "Device"
    type: string
    sql: ${TABLE}.DEVICESYSTEMNAME ;;
  }

  dimension: devicesystemtype {
    label: "Device system type"
    group_label: "Device"
    type: string
    sql: decode(${TABLE}.DEVICESYSTEMTYPE, 'Mobile/PDA', 'mobile', 'PC', 'desktop', ${TABLE}.DEVICESYSTEMTYPE) ;;
  }

  dimension: deviceuseragent {
    label: "Device user agent"
    group_label: "Device"
    type: string
    sql: ${TABLE}.DEVICEUSERAGENT ;;
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

  dimension_group: loaddate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  measure: count {
    label: "No. of different device/platforms"
    type: count
    drill_fields: [devicebrowsername, deviceplatformname, devicesystemname]
  }
}
