view: aplia_satisfaction {
  sql_table_name: STG_QUALTRICS.APLIA_SATISFACTION ;;

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

  dimension: qid1_1 {
    type: string
    sql: ${TABLE}.QID1_1 ;;
  }

  dimension: qid1_10 {
    type: string
    sql: ${TABLE}.QID1_10 ;;
  }

  dimension: qid1_11 {
    type: string
    sql: ${TABLE}.QID1_11 ;;
  }

  dimension: qid1_12 {
    type: string
    sql: ${TABLE}.QID1_12 ;;
  }

  dimension: qid1_13 {
    type: string
    sql: ${TABLE}.QID1_13 ;;
  }

  dimension: qid1_14 {
    type: string
    sql: ${TABLE}.QID1_14 ;;
  }

  dimension: qid1_15 {
    type: string
    sql: ${TABLE}.QID1_15 ;;
  }

  dimension: qid1_2 {
    type: string
    sql: ${TABLE}.QID1_2 ;;
  }

  dimension: qid1_3 {
    type: string
    sql: ${TABLE}.QID1_3 ;;
  }

  dimension: qid1_4 {
    type: string
    sql: ${TABLE}.QID1_4 ;;
  }

  dimension: qid1_5 {
    type: string
    sql: ${TABLE}.QID1_5 ;;
  }

  dimension: qid1_6 {
    type: string
    sql: ${TABLE}.QID1_6 ;;
  }

  dimension: qid1_7 {
    type: string
    sql: ${TABLE}.QID1_7 ;;
  }

  dimension: qid1_8 {
    type: string
    sql: ${TABLE}.QID1_8 ;;
  }

  dimension: qid1_9 {
    type: string
    sql: ${TABLE}.QID1_9 ;;
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

  dimension: qid47 {
    type: string
    sql: ${TABLE}.QID47 ;;
  }

  dimension: qid48 {
    type: string
    sql: ${TABLE}.QID48 ;;
  }

  dimension: qid49 {
    type: string
    sql: ${TABLE}.QID49 ;;
  }

  dimension: qid5 {
    type: string
    sql: ${TABLE}.QID5 ;;
  }

  dimension: qid51 {
    type: string
    sql: ${TABLE}.QID51 ;;
  }

  dimension: qid52 {
    type: string
    sql: ${TABLE}.QID52 ;;
  }

  dimension: qid53 {
    type: string
    sql: ${TABLE}.QID53 ;;
  }

  dimension: qid53_text {
    type: string
    sql: ${TABLE}.QID53_TEXT ;;
  }

  dimension: qid54_1 {
    type: string
    sql: ${TABLE}.QID54_1 ;;
  }

  dimension: qid54_2 {
    type: string
    sql: ${TABLE}.QID54_2 ;;
  }

  dimension: qid54_3 {
    type: string
    sql: ${TABLE}.QID54_3 ;;
  }

  dimension: qid54_4 {
    type: string
    sql: ${TABLE}.QID54_4 ;;
  }

  dimension: qid54_5 {
    type: string
    sql: ${TABLE}.QID54_5 ;;
  }

  dimension: qid54_5_text {
    type: string
    sql: ${TABLE}.QID54_5_TEXT ;;
  }

  dimension: qid55 {
    type: string
    sql: ${TABLE}.QID55 ;;
  }

  dimension: qid56_1 {
    type: string
    sql: ${TABLE}.QID56_1 ;;
  }

  dimension: qid56_2 {
    type: string
    sql: ${TABLE}.QID56_2 ;;
  }

  dimension: qid56_3 {
    type: string
    sql: ${TABLE}.QID56_3 ;;
  }

  dimension: qid56_4 {
    type: string
    sql: ${TABLE}.QID56_4 ;;
  }

  dimension: qid56_5 {
    type: string
    sql: ${TABLE}.QID56_5 ;;
  }

  dimension: qid57 {
    type: string
    sql: ${TABLE}.QID57 ;;
  }

  dimension: qid58 {
    type: string
    sql: ${TABLE}.QID58 ;;
  }

  dimension: qid59_1 {
    type: string
    sql: ${TABLE}.QID59_1 ;;
  }

  dimension: qid59_2 {
    type: string
    sql: ${TABLE}.QID59_2 ;;
  }

  dimension: qid59_3 {
    type: string
    sql: ${TABLE}.QID59_3 ;;
  }

  dimension: qid59_4 {
    type: string
    sql: ${TABLE}.QID59_4 ;;
  }

  dimension: qid59_5 {
    type: string
    sql: ${TABLE}.QID59_5 ;;
  }

  dimension: qid60_1 {
    type: string
    sql: ${TABLE}.QID60_1 ;;
  }

  dimension: qid60_2 {
    type: string
    sql: ${TABLE}.QID60_2 ;;
  }

  dimension: qid60_3 {
    type: string
    sql: ${TABLE}.QID60_3 ;;
  }

  dimension: qid60_4 {
    type: string
    sql: ${TABLE}.QID60_4 ;;
  }

  dimension: qid60_5 {
    type: string
    sql: ${TABLE}.QID60_5 ;;
  }

  dimension: qid61 {
    type: string
    sql: ${TABLE}.QID61 ;;
  }

  dimension: qid62_1 {
    type: string
    sql: ${TABLE}.QID62_1 ;;
  }

  dimension: qid62_2 {
    type: string
    sql: ${TABLE}.QID62_2 ;;
  }

  dimension: qid62_3 {
    type: string
    sql: ${TABLE}.QID62_3 ;;
  }

  dimension: qid62_4 {
    type: string
    sql: ${TABLE}.QID62_4 ;;
  }

  dimension: qid62_5 {
    type: string
    sql: ${TABLE}.QID62_5 ;;
  }

  dimension: qid63_1 {
    type: string
    sql: ${TABLE}.QID63_1 ;;
  }

  dimension: qid63_2 {
    type: string
    sql: ${TABLE}.QID63_2 ;;
  }

  dimension: qid63_3 {
    type: string
    sql: ${TABLE}.QID63_3 ;;
  }

  dimension: qid63_4 {
    type: string
    sql: ${TABLE}.QID63_4 ;;
  }

  dimension: qid63_5 {
    type: string
    sql: ${TABLE}.QID63_5 ;;
  }

  dimension: qid64 {
    type: string
    sql: ${TABLE}.QID64 ;;
  }

  dimension: qid65 {
    type: string
    sql: ${TABLE}.QID65 ;;
  }

  dimension: qid65_text {
    type: string
    sql: ${TABLE}.QID65_TEXT ;;
  }

  dimension: qid66 {
    type: string
    sql: ${TABLE}.QID66 ;;
  }

  dimension: qid67 {
    type: string
    sql: ${TABLE}.QID67 ;;
  }

  dimension: qid68 {
    type: string
    sql: ${TABLE}.QID68 ;;
  }

  dimension: qid69 {
    type: string
    sql: ${TABLE}.QID69 ;;
  }

  dimension: qid70_1 {
    type: string
    sql: ${TABLE}.QID70_1 ;;
  }

  dimension: qid70_2 {
    type: string
    sql: ${TABLE}.QID70_2 ;;
  }

  dimension: qid70_3 {
    type: string
    sql: ${TABLE}.QID70_3 ;;
  }

  dimension: qid70_4 {
    type: string
    sql: ${TABLE}.QID70_4 ;;
  }

  dimension: qid71 {
    type: string
    sql: ${TABLE}.QID71 ;;
  }

  dimension: qid72 {
    type: string
    sql: ${TABLE}.QID72 ;;
  }

  dimension: qid73 {
    type: string
    sql: ${TABLE}.QID73 ;;
  }

  dimension: qid74 {
    type: string
    sql: ${TABLE}.QID74 ;;
  }

  dimension: qid75 {
    type: string
    sql: ${TABLE}.QID75 ;;
  }

  dimension: qid76 {
    type: string
    sql: ${TABLE}.QID76 ;;
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

  dimension: startdate {
    type: string
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
}
