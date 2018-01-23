view: fact_activity {
  label: "Learning Path Modifications"
  #sql_table_name: DW_GA.FACT_ACTIVITY ;;
  derived_table: {
    sql:
      with a as (
        select a.*
            ,to_timestamp_tz(a.createddatekey || right('0' || regexp_replace(a.timekey, '24(\\d\\d)', '00\\1'), 4), 'YYYYMMDDHH24MI') as created_time
            ,to_timestamp_tz(
                lead(a.createddatekey) over (partition by a.courseid, a.learningpathid order by a.createddatekey, a.timekey)
                || right('0' ||
                    lead(regexp_replace(timekey, '24(\\d\\d)', '00\\1')) over (partition by a.courseid, a.learningpathid order by a.createddatekey, a.timekey)
                    ,4)
              , 'YYYYMMDDHH24MI') as next_created_time
        from dw_ga.fact_activity a
       )
      select
        a.*
        ,case when row_number() over (partition by courseid, learningpathid order by loaddate) = 1 then 0::timestamp else created_time end as fromdate
        ,case when row_number() over (partition by courseid, learningpathid order by loaddate desc) = 1 then current_timestamp() else next_created_time end as todate
      from a
      where (
        created_time != next_created_time
        or next_created_time is null)
      order by courseid, learningpathid, created_time, next_created_time
      ;;
      sql_trigger_value: select count(*) from dw_ga.fact_activity ;;
  }
  set: curated_fields { }

  dimension: created_time {
    hidden: yes
  }

  dimension: next_created_time {
    hidden: yes
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
    hidden: yes
  }

  dimension: activityid {
    type: string
    sql: ${TABLE}.ACTIVITYID ;;
    hidden: yes
  }

  dimension: courseid {
    type: string
    hidden: yes
    sql: ${TABLE}.COURSEID ;;
  }

  dimension: coursesnapshoteventid {
    type: string
    sql: ${TABLE}.COURSESNAPSHOTEVENTID ;;
    hidden: yes
  }

  dimension: createddatekey {
    type: string
    sql: ${TABLE}.CREATEDDATEKEY ;;
    hidden: yes
  }

  dimension: daysbeforecourseend {
    type: string
    sql: ${TABLE}.DAYSBEFORECOURSEEND ;;
    hidden: yes
  }

  dimension: daysfromcoursestart {
    type: string
    sql: ${TABLE}.DAYSFROMCOURSESTART ;;
    hidden: yes
  }

  dimension: dw_ldid {
    type: string
    sql: ${TABLE}.DW_LDID ;;
    hidden: yes
  }

  dimension: dw_ldts {
    type: string
    sql: ${TABLE}.DW_LDTS ;;
    hidden: yes
  }

  dimension: eventtypeid {
    type: string
    sql: ${TABLE}.EVENTTYPEID ;;
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

  dimension: institutionlocationid {
    type: string
    sql: ${TABLE}.INSTITUTIONLOCATIONID ;;
    hidden: yes
  }

  dimension: learningpathid {
    type: string
    sql: ${TABLE}.LEARNINGPATHID ;;
    hidden: yes
  }

  dimension: loaddate {
    type: string
    sql: ${TABLE}.LOADDATE ;;
    hidden: yes
  }

  dimension: partyid {
    type: string
    sql: ${TABLE}.PARTYID ;;
    hidden: yes
  }

  dimension: productid {
    type: string
    sql: ${TABLE}.PRODUCTID ;;
    hidden: yes
  }

  dimension: snapshotid {
    type: string
    sql: ${TABLE}.SNAPSHOTID ;;
    hidden: yes
  }

  dimension: timekey {
    type: string
    sql: ${TABLE}.TIMEKEY ;;
    hidden: yes
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.USERID ;;
    hidden: yes
  }

  measure: count {
    label: "# Actions"
    type: count
    hidden: yes
    drill_fields: [dim_product.discipline, dim_institution.institutionname, dim_activity.assignment_status, dim_learningpath.lowest_level, count]
  }
}
