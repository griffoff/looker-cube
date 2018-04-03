connection: "snowflake_prod"
label:"Source Data on Snowflake"
include: "/core/common.lkml"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "dims.lkml"
include: "/project_source/*.view.lkml"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

# # Database Metadata
# explore: schema_comparison {
#   label: "Compare schemas: STG to PROD "
#   join: table_comparison {
#     sql_on: ${schema_comparison.schema_name} = ${table_comparison.schema_name};;
#     relationship: one_to_many
#   }
#   join: column_comparison {
#     sql_on: (${table_comparison.schema_name}, ${table_comparison.table_name}) = (${column_comparison.schema_name}, ${column_comparison.table_name}) ;;
#     relationship: one_to_many
#   }
# }
#
# explore: tables {
#   label: "Information Schema"
#
#   join: load_history {
#     sql_on: ${tables.table_catalog} = ${load_history.table_catalog}
#           and ${tables.table_schema} = ${load_history.schema_name}
#           and ${tables.table_name} = ${load_history.table_name};;
#   }
#
#   join: columns {
#     sql_on:  ${tables.table_catalog} = ${columns.table_catalog}
#           and ${tables.table_schema} = ${columns.table_schema}
#           and ${tables.table_name} = ${columns.table_name};;
#   }
# }
#
#
# # CLTS
# explore: olr_courses {
#   label: "CLTS - Courses"
#   join: entities{
#     sql_on: ${olr_courses.entity_no} = ${entities.entity_no} ;;
#     relationship: many_to_one
#   }
#   join: products {
#     sql_on: ${olr_courses.isbn} = ${products.isbn13} ;;
#     relationship: many_to_one
#   }
#
#   join: activations_olr {
#     sql_on: ${olr_courses.context_id}=${activations_olr.context_id} ;;
#     relationship: one_to_many
#   }
# }

# APLIA
explore: aplia_course_map {
  extends: [dim_course]
  label: "Aplia - Course"

  join: apliacontext {
    sql_on: ${apliacontext.guid}=${aplia_course_map.guid} ;;
    relationship: one_to_one
  }

  join: apliacontent{
    sql_on: ${apliacontent.context_guid} = ${aplia_course_map.guid} ;;
    relationship: one_to_many
  }

  join: course {
    sql_on: ${course.course_id} = ${aplia_course_map.course_id} ;;
    relationship: one_to_many
  }

  join: problem {
    sql_on: ${apliacontent.guid} = ${problem.problem_set_guid};;
    relationship: one_to_many
  }

  join: answer{
    sql_on: ${problem.guid} = ${answer.problem_guid};;
    relationship: one_to_many
  }

  join: assignment{
    sql_on: ${assignment.guid} = ${apliacontent.assignment_guid} ;;
    relationship: one_to_many
  }

  join: instructor {
    from: membership
    view_label: "Instructors"
    sql_on: ${course.guid} = ${instructor.context_guid} and ${instructor.role_guid} = 'ROLE041651A500E908EF3A1E80000000' ;;
    relationship: one_to_many
  }
  join:  instructor_apliauser {
    from: apliauser
    view_label: "Instructors"
    sql_on: ${instructor.user_guid} = ${instructor_apliauser.guid};;
    relationship: one_to_one
  }

  join: student {
    from: membership
    view_label: "Students"
    sql_on: ${course.guid} = ${student.context_guid} and ${student.role_guid} = 'ROLE041651A500E908EE3FFE80000000' ;;
    relationship: one_to_many
  }

  join:  student_apliauser {
    from: apliauser
    view_label: "Students"
    sql_on: ${student.user_guid} = ${student_apliauser.guid};;
    relationship: one_to_one
  }

  join: dim_course {
    view_label: " Cube - Course/Section"
    #use reg_key = coursekey
    #sql_on: case when ${aplia_course_map.mindtap_course_yn} > 0 then ${apliacontext.reg_key} else ${apliacontext.context_id} end = ${dim_course.coursekey};;
    sql_on: ${apliacontext.reg_key} = ${dim_course.olr_course_key} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    view_label: " Cube - Course/Section"
  }

  join: dim_product {
    view_label: " Cube - Product"
  }

  join: dim_productplatform {
    view_label: " Cube - Product"
  }

  join: products {
    view_label: " Cube - Product"
  }

  join: dim_institution {
    view_label: " Cube - Institution"
  }

  join: dim_location {
    view_label: " Cube - Institution"
  }

  join: dim_start_date {
    view_label: " Cube - Course Start Date"
  }

  join: course_section_facts {
    view_label: " Cube - Activations"
  }

  join: product_facts {
    view_label: " Cube - Activations"
  }

}

explore: problem {
  extends: [dim_course]
  label: "Aplia - Problem"

  join: apliacontent{
    sql_on: ${problem.problem_set_guid} = ${apliacontent.guid} ;;
    relationship: many_to_one
  }
  join: aplia_course_map {
    #sql: right join ${aplia_course_map.SQL_TABLE_NAME} on ${aplia_course_map.guid} = ${apliacontent.context_guid} ;;
    sql_on: ${aplia_course_map.guid} = ${apliacontent.context_guid} ;;
    relationship: many_to_one
  }
  join: course {
    sql_on: ${course.course_id} = ${aplia_course_map.course_id} ;;
    relationship: one_to_one
  }

  join: answer{
    sql_on: ${answer.problem_guid} = ${problem.guid} ;;
    relationship: one_to_many
  }
  join: assignment{
    sql_on: ${assignment.guid} = ${apliacontent.assignment_guid} ;;
    relationship: one_to_many
  }

  join: apliacontext {
    sql_on: ${apliacontext.guid}=${aplia_course_map.guid} ;;
    relationship: one_to_many
  }

   join:  membership {
     sql_on: ${course.guid} = ${membership.context_guid} ;;
   }
   join: instructor {
     from: membership
     view_label: "Instructors"
     sql_on: course.guid = instructor.context_guid and instructor.role_guid = 'ROLE041651A500E908EF3A1E80000000' ;;
   }
   join:  apliauser {
     sql_on: ${membership.user_guid} = ${apliauser.guid}
     AND user_id not like '%aplia.com'
     AND user_id not like  '%cengage.com';;
   }

   join: student {
     from: membership
     view_label: "Students"
     sql_on: course.guid = student.context_guid and student.role_guid = 'ROLE041651A500E908EE3FFE80000000' ;;
     # count(student) > 2 - filter internal data
   }

  join: dim_course {
    view_label: " Cube - Course/Section"
    #use reg_key = coursekey
    #sql_on: case when ${aplia_course_map.mindtap_course_yn} > 0 then ${apliacontext.reg_key} else ${apliacontext.context_id} end = ${dim_course.coursekey};;
    sql_on: ${apliacontext.reg_key} = ${dim_course.olr_course_key} ;;
    relationship: many_to_one
  }

  join: dim_filter {
    view_label: " Cube - Course/Section"
  }

  join: dim_product {
    view_label: " Cube - Product"
  }

  join: dim_productplatform {
    view_label: " Cube - Product"
  }

  join: products {
    view_label: " Cube - Product"
  }

  join: dim_institution {
    view_label: " Cube - Institution"
  }

  join: dim_location {
    view_label: " Cube - Institution"
  }

  join: dim_start_date {
    view_label: " Cube - Course Start Date"
  }

  join: course_section_facts {
    view_label: " Cube - Activations"
  }

  join: product_facts {
    view_label: " Cube - Activations"
  }

}



# # MindTap
# explore: master {
#   label: "MindTap - Master"
#   from:  snapshot
#
#   sql_always_where: ${is_master} = 1 ;;
#
#   join: master_node {
#     from: node
#     sql_on: ${master.id} = ${master_node.snapshot_id} ;;
#     relationship: one_to_many
#   }
#
#   join: snapshot {
#     sql_on: ${master.id} = ${snapshot.source_id} ;;
#     relationship: one_to_many
#   }
#
#   join: org {
#     sql_on: ${snapshot.org_id} = ${org.id} ;;
#     relationship: many_to_one
#   }
#
#   join: node {
#     sql_on: (${snapshot.id},${master_node.id}) = (${node.snapshot_id},${node.origin_id}) ;;
#     relationship: one_to_many
#   }
#
#   join: activity_outcome {
#     sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
#     relationship: one_to_many
#   }
#
#
# }
# explore: snapshot {
#   label: "MindTap - Snapshot"
#
#   # join to parent snapshot
#   join: master {
#     from:  snapshot
#     sql_on: ${snapshot.parent_id} = ${master.id} ;;
#   }
#
#   join:  org {
#     sql_on: ${snapshot.org_id} = ${org.id} ;;
#     relationship: one_to_one
#   }
#
#   join:  parent_org {
#     from: org
#     sql_on: ${org.parent_id} = ${parent_org.id} ;;
#     relationship: one_to_one
#   }
#
#   join:  node {
#     sql_on: ${snapshot.id} = ${node.snapshot_id} ;;
#     relationship: one_to_many
#   }
#
#   join: user_org_profile {
#     sql_on: ${snapshot.org_id} = ${user_org_profile.org_id} ;;
#     relationship: one_to_many
#   }
#
#   join:  role {
#     sql_on: ${user_org_profile.role_id} = ${role.id} ;;
#     relationship: many_to_one
#   }
#  join: activity {
#    sql_on:  ${node.id} = ${activity.id};;
#    relationship: one_to_one
#  }
#
#  join: created_by_user {
#     view_label: "User - Created By"
#     from: user
#     sql_on:  ${node.created_by} = ${created_by_user.id};;
#     relationship: many_to_one
#   }
#
#   join: created_by_user_org_profile {
#     from: user_org_profile
#     sql_on: (${snapshot.org_id}, ${node.created_by}) = (${created_by_user_org_profile.org_id}, ${created_by_user_org_profile.user_id}) ;;
#     relationship: one_to_one
#   }
#
#   join: created_by_role {
#     from:  role
#     sql_on: ${created_by_user_org_profile.role_id} = ${created_by_role.id} ;;
#     relationship: many_to_one
#   }
#
#   join:  app_activity {
#     sql_on: ${activity.app_activity_id} = ${app_activity.id} ;;
#     relationship: many_to_one
#   }
#
#   join: app {
#     sql_on: ${app_activity.app_id} = ${app.id} ;;
#     relationship: many_to_one
#   }
#
#   join: activity_outcome {
#     sql_on: ${node.id} = ${activity_outcome.activity_id} ;;
#     relationship: one_to_many
#   }
#
#   join: activity_outcome_detail {
#     sql_on: ${activity_outcome.id} = ${activity_outcome_detail.activity_outcome_id} ;;
#     relationship: one_to_many
#   }
#
#   join: student {
#     view_label: "User - Student"
#     from: user
#     sql_on:  ${activity_outcome.user_id} = ${student.id};;
#     relationship: many_to_many
#   }
#
# }


explore: ga_data_parsed {
  label: "Google Analytics Data"
  extends: [dim_course]
  join: user_facts {
    relationship: many_to_one
    sql_on: ${ga_data_parsed.userssoguid} = ${user_facts.guid} ;;
  }
  join: user_final_scores {
    sql_on: (${dim_course.courseid}, ${ga_data_parsed.userssoguid}) = (${user_final_scores.courseid}, ${user_final_scores.sso_guid}) ;;
    relationship: many_to_one
  }
  join: dim_course {
    relationship: many_to_one
    sql_on: ${ga_data_parsed.coursekey} = ${dim_course.coursekey} ;;
  }
  join: dim_relative_to_start_date {
    relationship: many_to_one
    sql_on: datediff(days, ${olr_courses.begin_date_date}, ${ga_data_parsed.hit_date}) = ${dim_relative_to_start_date.days} ;;
  }
}
