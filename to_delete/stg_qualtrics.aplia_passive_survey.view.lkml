view: aplia_passive_survey {
  sql_table_name: STG_QUALTRICS.APLIA_PASSIVE_SURVEY ;;

  dimension: coursecontextid {
    type: string
    sql: ${TABLE}.COURSECONTEXTID ;;
  }

  dimension: courseinstitution {
    type: string
    sql: ${TABLE}.COURSEINSTITUTION ;;
  }

  dimension: currenturl {
    type: string
    sql: ${TABLE}.CURRENTURL ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.DEVICE ;;
  }

  dimension: emailaddress {
    type: string
    sql: ${TABLE}.EMAILADDRESS ;;
  }

  dimension: enddate {
    type: string
    sql: ${TABLE}.ENDDATE ;;
  }

  dimension: externaldatareference {
    type: string
    sql: ${TABLE}.EXTERNALDATAREFERENCE ;;
  }

  dimension: feedbackcookie {
    type: string
    sql: ${TABLE}.FEEDBACKCOOKIE ;;
  }

  dimension: finished {
    type: string
    sql: ${TABLE}.FINISHED ;;
  }

  dimension: iacisbn {
    type: string
    sql: ${TABLE}.IACISBN ;;
  }

  dimension: ipaddress {
    type: string
    sql: ${TABLE}.IPADDRESS ;;
  }

  dimension: ldts {
    type: string
    sql: ${TABLE}.LDTS ;;
  }

  dimension: locationaccuracy {
    type: string
    sql: ${TABLE}.LOCATIONACCURACY ;;
  }

  dimension: locationlatitude {
    type: string
    sql: ${TABLE}.LOCATIONLATITUDE ;;
  }

  dimension: locationlongitude {
    type: string
    sql: ${TABLE}.LOCATIONLONGITUDE ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: qid1 {
    type: string
    sql: ${TABLE}.QID1 ;;
  }

  dimension: qid2 {
    type: string
    sql: ${TABLE}.QID2 ;;
  }

  dimension: qid3 {
    type: string
    sql: ${TABLE}.QID3 ;;
  }

  dimension: qid4 {
    type: string
    sql: ${TABLE}.QID4 ;;
  }

  dimension: qid5 {
    type: string
    sql: ${TABLE}.QID5 ;;
  }

  dimension: qid6 {
    type: string
    sql: ${TABLE}.QID6 ;;
  }

  dimension: responseid {
    type: string
    sql: ${TABLE}.RESPONSEID ;;
  }

  dimension: responseset {
    type: string
    sql: ${TABLE}.RESPONSESET ;;
  }

  dimension: rsrc {
    type: string
    sql: ${TABLE}.RSRC ;;
  }

   dimension_group: startdate {
    label: "Survey Date"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.STARTDATE ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.STATUS ;;
  }

  dimension: stg_ldid {
    type: string
    sql: ${TABLE}.STG_LDID ;;
  }

  dimension: textbookauthor {
    type: string
    sql: ${TABLE}.TEXTBOOKAUTHOR ;;
  }

  dimension: textbookdiscipline {
    type: string
    sql: ${TABLE}.TEXTBOOKDISCIPLINE ;;
  }

  dimension: textbookedition {
    type: string
    sql: ${TABLE}.TEXTBOOKEDITION ;;
  }

  dimension: textbookisbn {
    type: string
    sql: ${TABLE}.TEXTBOOKISBN ;;
  }

  dimension: textbooktitle {
    type: string
    sql: ${TABLE}.TEXTBOOKTITLE ;;
  }

  dimension: tos {
    type: string
    sql: ${TABLE}.TOS ;;
  }

  dimension: usertype {
    type: string
    sql: ${TABLE}.USERTYPE ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }

  measure: promoter {
    type: sum
    sql:
    case when ${qid5} = 'Don''t know' or ${qid5} is null then null
      when split_part(${qid5}, '- ', 1)::int >= 9  then 1
      else null
      end
    ;;
    }

measure: neutral {
    type: sum
    sql:
    case when ${qid5} = 'Don''t know' or ${qid5} is null then null
      when split_part(${qid5}, '- ', 1)::int between 7 and 8 then 1
      else null
      end
    ;;
}

measure: detractor {
    type: sum
    sql:
    case when ${qid5} = 'Don''t know' or ${qid5} is null then null
      when split_part(${qid5}, '- ', 1)::int <=6  then 1
      else null
      end
    ;;
  }

  measure: NPSRespondent {
    type: sum
    sql:
    case
      when ${qid5} is not null  then 1
      else null
      end
    ;;
  }

measure: NPSScore {
  type: number
  sql:
    (${promoter}-${detractor})/nullif(${NPSRespondent},0)
                ;;
    value_format_name: percent_0
}
}
