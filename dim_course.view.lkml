view: dim_course {
  label: "Course"
  sql_table_name: DW_GA.DIM_COURSE ;;

  dimension: courseid {
    type: string
    sql: ${TABLE}.COURSEID ;;
    hidden: yes
  }

  dimension: coursekey {
    label: "Course Key"
    type: string
    sql: ${TABLE}.COURSEKEY ;;
    primary_key: yes

    link: {
      label: "Engagement Toolkit (Looker)"
      url: "https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{value}}"
    }

    link: {
      label: "Engagement Toolkit (Dev)"
      url: "http://dashboard-dev.cengage.info/engtoolkit/{{value}}"
    }

    link: {
      label: "Engagement Toolkit - Discipline (Dev)"
      url: "http://dashboard-dev.cengage.info/engtoolkit/discipline/{{dim_product.hed_discipline._value}}"
    }
  }

  dimension: coursename {
    label: "Course Name"
    type: string
    sql: ${TABLE}.COURSENAME ;;

    link: {
      label: "Engagement Toolkit Looker"
      url: "https://cengage.looker.com/dashboards/test::engagement_toolkit?filter_course={{dim_course.coursekey._value}}"
    }

    link: {
      label: "Engagement Toolkit - Discipline {{dim_product.discipline._value}} (Dev)"
      url: "http://dashboard-dev.cengage.info/engtoolkit/discipline/{{dim_product.discipline._value}}"
    }

    link: {
      label: "Engagement Toolkit (Live)"
      url: "http://dashboard.cengage.info/engtoolkit/{{dim_course.coursekey._value}}"
    }
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

  dimension: enddatekey {
    type: string
    sql: ${TABLE}.ENDDATEKEY ;;
    hidden: yes
  }

  dimension: filterflag {
    type: string
    sql: ${TABLE}.FILTERFLAG ;;
    hidden: yes
  }

  dimension: institutionid {
    type: string
    sql: ${TABLE}.INSTITUTIONID ;;
    hidden: yes
  }

  dimension: learningcourse {
    type: string
    sql: ${TABLE}.LEARNINGCOURSE ;;
    hidden: yes
  }

  dimension_group: loaddate {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: productplatformid {
    type: string
    sql: ${TABLE}.PRODUCTPLATFORMID ;;
    hidden: yes
  }

  dimension: startdatekey {
    type: string
    sql: ${TABLE}.STARTDATEKEY ;;
    hidden: yes
  }

  measure: count {
    label: "No. of Courses"
    type: count
    drill_fields: [coursename]
  }
}
