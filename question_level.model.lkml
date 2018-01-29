connection: "snowflake_prod"
include: "dims.model.lkml"
include: "/core/common.lkml"

label:"Item Analysis"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lkml"  # include all dashboards in this project

explore: dataprofiling {
  label: "Data Profiling"
}

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

explore: productqnaproblemview {
  label: "Aplia Link"
  extension: required
  extends: [dim_course]
  join: dim_course {
    sql_on: ${productqnaproblemview.context_id} = ${dim_course.coursekey};;
    relationship: many_to_one
  }
}

explore: problems_assigned {
  label: "Aplia Usage Data"
  extension: required
  extends: [productqnaproblemview]
  join: productqnaproblemview {
    sql_on: ${problems_assigned.problem_id} = ${productqnaproblemview.problem_id};;
    relationship: many_to_one
  }
}

explore: problem_usage {
  label: "Aplia Usage Data actual and possible"
  extension: required
  extends: [productqnaproblemview]
  join: productqnaproblemview {
    sql_on: ${problem_usage.problem_id} = ${productqnaproblemview.problem_id};;
    relationship: many_to_one
  }
}

explore: product_family_raw {
  label: "Product_Family Rollup"
  extends: [problem_product_family_year]
  join: problem_product_family_year {
    sql_on: ${problem_product_family_year.productfamily} = ${product_family_raw.productfamily};;
    relationship: many_to_one
  }
}
explore: problem_product_family_year {
  label: "Aplia Usage Data actual and possible year over year"
  extends: [dim_course]
  join: dim_course {
    sql_on: ${problem_product_family_year.coursekey} = ${dim_course.coursekey};;
    relationship: many_to_one
  }
}

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
      type: inner
    }

    join: item_properties {
      sql_on: ${all_questions.activityitemuri} = ${item_properties.activity_activityitemuri} ;;
      relationship: many_to_one
    }

    join: item_taxonomy {
      sql_on: ${all_questions.activityitemuri} = ${item_taxonomy.activity_activityitemuri} ;;
      relationship: many_to_many
    }

#     join: dim_productplatform {
#       sql_on: split_part(${all_questions.activityuri}, ':', 1) = lower(${dim_productplatform.productplatform}) ;;
#       relationship: many_to_one
#     }
}
