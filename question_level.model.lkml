connection: "snowflake_migration_test"
include: "dims.model.lkml"

label:"Item Analysis"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lkml"  # include all dashboards in this project

explore: csfitakes {
  label: "CSFI data"
  extends: [dim_course]
   join: dim_course {
      sql_on: ${csfitakes.coursekey} = ${dim_course.coursekey};;
      relationship: many_to_one
   }
  }

# explore: mankiw_questions {
#   label: "Mankiw data"
#   extends: [dim_course]
#   join: dim_course {
#     sql_on: ${mankiw_questions.coursekey} = ${dim_course.coursekey};;
#     relationship: many_to_one
#     }
#   }
# explore: soa_questions {
#   label: "SOA data"
#   extends: [dim_course]
#   join: dim_course {
#     sql_on: ${soa_questions.coursekey} = ${dim_course.coursekey};;
#     relationship: many_to_one
#   }
# }

explore: all_questions {
    label: "All Covalent data"
    extends: [dim_course]
    join: dim_course {
      sql_on: ${all_questions.coursekey} = ${dim_course.coursekey};;
      relationship: many_to_one
    }

    join: dim_creationdate {
      view_label: "Activity Creation Date"
      from: dim_date
      sql_on: ${all_questions.activity_creationDateKey} = ${dim_creationdate.datekey} ;;
      relationship: many_to_one
    }

#     join: dim_productplatform {
#       sql_on: split_part(${all_questions.activityuri}, ':', 1) = lower(${dim_productplatform.productplatform}) ;;
#       relationship: many_to_one
#     }
}
