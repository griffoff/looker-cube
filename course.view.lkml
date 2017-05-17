view: course {
  view_label: "Aplia Course"
  sql_table_name: STG_APLIA.COURSE ;;

  dimension: course_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.COURSE_ID ;;
  }

  dimension: accept_direct_payment_yn {
    type: string
    sql: ${TABLE}.ACCEPT_DIRECT_PAYMENT_YN ;;
  }

  dimension: accept_payment_code_yn {
    type: string
    sql: ${TABLE}.ACCEPT_PAYMENT_CODE_YN ;;
  }

  dimension: assignment_submission_yn {
    type: string
    sql: ${TABLE}.ASSIGNMENT_SUBMISSION_YN ;;
  }

  dimension: begin_date {
    type: string
    sql: ${TABLE}.BEGIN_DATE ;;
  }

  dimension: col_52 {
    type: string
    sql: ${TABLE}.COL_52 ;;
  }

  dimension: col_53 {
    type: string
    sql: ${TABLE}.COL_53 ;;
  }

  dimension: col_54 {
    type: string
    sql: ${TABLE}.COL_54 ;;
  }

  dimension: col_55 {
    type: string
    sql: ${TABLE}.COL_55 ;;
  }

  dimension: course_creator_id {
    type: string
    sql: ${TABLE}.COURSE_CREATOR_ID ;;
  }

  dimension: create_date {
    type: string
    sql: ${TABLE}.CREATE_DATE ;;
  }

  dimension: creation_status {
    type: string
    sql: ${TABLE}.CREATION_STATUS ;;
  }

  dimension: enable_discussion_yn {
    type: string
    sql: ${TABLE}.ENABLE_DISCUSSION_YN ;;
  }

  dimension: enable_etext_yn {
    type: string
    sql: ${TABLE}.ENABLE_ETEXT_YN ;;
  }

  dimension: enable_gradebook_yn {
    type: string
    sql: ${TABLE}.ENABLE_GRADEBOOK_YN ;;
  }

  dimension: end_date {
    type: string
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: feedback_review_on_submit_yn {
    type: string
    sql: ${TABLE}.FEEDBACK_REVIEW_ON_SUBMIT_YN ;;
  }

  dimension: gin_grading_mode {
    type: string
    sql: ${TABLE}.GIN_GRADING_MODE ;;
  }

  dimension: guid {
    type: string
    sql: ${TABLE}.GUID ;;
  }

  dimension: have_section_yn {
    type: string
    sql: ${TABLE}.HAVE_SECTION_YN ;;
  }

  dimension: idioms_path {
    type: string
    sql: ${TABLE}.IDIOMS_PATH ;;
  }

  dimension: is_gateway_course {
    type: string
    sql: ${TABLE}.IS_GATEWAY_COURSE ;;
  }

  dimension: lms_id {
    type: string
    sql: ${TABLE}.LMS_ID ;;
  }

  dimension: lti_guid {
    type: string
    sql: ${TABLE}.LTI_GUID ;;
  }

  dimension: material_folder_id {
    type: string
    sql: ${TABLE}.MATERIAL_FOLDER_ID ;;
  }

  dimension: mindtap_course_yn {
    type: string
    sql: ${TABLE}.MINDTAP_COURSE_YN ;;
  }

  dimension: mindtap_master_id {
    type: string
    sql: ${TABLE}.MINDTAP_MASTER_ID ;;
  }

  dimension: mindtap_parent_id {
    type: string
    sql: ${TABLE}.MINDTAP_PARENT_ID ;;
  }

  dimension: mindtap_snapshot_id {
    type: string
    sql: ${TABLE}.MINDTAP_SNAPSHOT_ID ;;
  }

  dimension: num_payment_grace_period_days {
    type: string
    sql: ${TABLE}.NUM_PAYMENT_GRACE_PERIOD_DAYS ;;
  }

  dimension: online_isbn_override {
    type: string
    sql: ${TABLE}.ONLINE_ISBN_OVERRIDE ;;
  }

  dimension: payment_on_aplia_yn {
    type: string
    sql: ${TABLE}.PAYMENT_ON_APLIA_YN ;;
  }

  dimension: payment_required_yn {
    type: string
    sql: ${TABLE}.PAYMENT_REQUIRED_YN ;;
  }

  dimension: points_locked_yn {
    type: string
    sql: ${TABLE}.POINTS_LOCKED_YN ;;
  }

  dimension: practice_with_save_yn {
    type: string
    sql: ${TABLE}.PRACTICE_WITH_SAVE_YN ;;
  }

  dimension: price {
    type: string
    sql: ${TABLE}.PRICE ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: reminder_emails_yn {
    type: string
    sql: ${TABLE}.REMINDER_EMAILS_YN ;;
  }

  dimension: require_email_validation_yn {
    type: string
    sql: ${TABLE}.REQUIRE_EMAIL_VALIDATION_YN ;;
  }

  dimension: require_student_id_yn {
    type: string
    sql: ${TABLE}.REQUIRE_STUDENT_ID_YN ;;
  }

  dimension: second_term_credit_override {
    type: string
    sql: ${TABLE}.SECOND_TERM_CREDIT_OVERRIDE ;;
  }

  dimension: section_instruction {
    type: string
    sql: ${TABLE}.SECTION_INSTRUCTION ;;
  }

  dimension: show_percentage_gradebook_yn {
    type: string
    sql: ${TABLE}.SHOW_PERCENTAGE_GRADEBOOK_YN ;;
  }

  dimension: show_student_grades_total_yn {
    type: string
    sql: ${TABLE}.SHOW_STUDENT_GRADES_TOTAL_YN ;;
  }

  dimension: signup_validation_id {
    type: string
    sql: ${TABLE}.SIGNUP_VALIDATION_ID ;;
  }

  dimension: student_id_instructions {
    type: string
    sql: ${TABLE}.STUDENT_ID_INSTRUCTIONS ;;
  }

  dimension: student_id_other_prompt {
    type: string
    sql: ${TABLE}.STUDENT_ID_OTHER_PROMPT ;;
  }

  dimension: student_id_prompt_type {
    type: string
    sql: ${TABLE}.STUDENT_ID_PROMPT_TYPE ;;
  }

  dimension: student_id_required_length {
    type: string
    sql: ${TABLE}.STUDENT_ID_REQUIRED_LENGTH ;;
  }

  dimension: study_tools_cutoff {
    type: string
    sql: ${TABLE}.STUDY_TOOLS_CUTOFF ;;
  }

  dimension: textbook_purchase_available {
    type: string
    sql: ${TABLE}.TEXTBOOK_PURCHASE_AVAILABLE ;;
  }

  dimension: two_term_price_override {
    type: string
    sql: ${TABLE}.TWO_TERM_PRICE_OVERRIDE ;;
  }

  dimension: university_id {
    type: string
    sql: ${TABLE}.UNIVERSITY_ID ;;
  }

  dimension: university_name {
    type: string
    sql: ${TABLE}.UNIVERSITY_NAME ;;
  }

  dimension: view_all_attempts_yn {
    type: string
    sql: ${TABLE}.VIEW_ALL_ATTEMPTS_YN ;;
  }

  measure: count {
    type: count
    drill_fields: [course_id, university_name]
  }
}
