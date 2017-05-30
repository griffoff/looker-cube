connection: "snowflake_prod"
label:"Source Data on Snowflake"
include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "dims.model.lkml"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: olr_courses {
  label: "CLTS - Courses"
  join: entities{
    sql_on: ${olr_courses.entity_no} = ${entities.entity_no} ;;
    relationship: many_to_one
  }
  join: products {
    sql_on: ${olr_courses.isbn} = ${products.isbn13} ;;
    relationship: many_to_one
  }

  join: activations_olr {
    sql_on: ${olr_courses.context_id}=${activations_olr.context_id} ;;
    relationship: one_to_many
  }

  join: magellan_hed_entities {
    sql_on: ${activations_olr.entity_no} = ${magellan_hed_entities.entity_no} ;;
    relationship: many_to_one
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

  join: dim_course {
    view_label: " Cube - Course/Section"
    #use reg_key = coursekey
    #sql_on: case when ${aplia_course_map.mindtap_course_yn} > 0 then ${apliacontext.reg_key} else ${apliacontext.context_id} end = ${dim_course.coursekey};;
    sql_on: ${apliacontext.reg_key} = ${dim_course.olr_course_key} ;;
    relationship: many_to_one
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

  join: course_facts {
    view_label: " Cube - Course/Section"
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

  join: fact_activation_by_course {
    view_label: " Cube - Activations"
  }

  join: fact_activation_by_product {
    view_label: " Cube - Activations"
  }


}

explore: snapshot {
  label: "MindTap - Snapshot"

  join:  org {
    sql_on: ${snapshot.org_id} = ${org.id} ;;
    relationship: one_to_one
  }

  join:  parent_org {
    from: org
    sql_on: ${org.parent_id} = ${parent_org.id} ;;
    relationship: one_to_one
  }

  join:  node {
    sql_on: ${snapshot.id} = ${node.snapshot_id} ;;
    relationship: one_to_many
  }

  join: user_org_profile {
    sql_on: ${snapshot.org_id} = ${user_org_profile.org_id} ;;
    relationship: one_to_many
  }

  join:  role {
    sql_on: ${user_org_profile.role_id} = ${role.id} ;;
    relationship: many_to_one
  }
 join: activity {
   sql_on:  ${node.id} = ${activity.id};;
   relationship: one_to_one
 }

 join: created_by_user {
    view_label: "Created By"
    from: user
    sql_on:  ${node.created_by} = ${created_by_user.id};;
    relationship: many_to_one
  }

  join: created_by_user_org_profile {
    from: user_org_profile
    sql_on: (${snapshot.org_id}, ${node.created_by}) = (${created_by_user_org_profile.org_id}, ${created_by_user_org_profile.user_id}) ;;
    relationship: one_to_one
  }

  join: created_by_role {
    from:  role
    sql_on: ${created_by_user_org_profile.role_id} = ${created_by_role.id} ;;
    relationship: many_to_one
  }

  join:  app_activity {
    sql_on: ${activity.app_activity_id} = ${app_activity.id} ;;
    relationship: many_to_one
  }

  join: app {
    sql_on: ${app_activity.app_id} = ${app.id} ;;
    relationship: many_to_one
  }

}
