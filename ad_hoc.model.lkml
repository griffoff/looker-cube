connection: "snowflake_prod"

include: "//core/common.lkml"
include: "*.view.lkml"
# include: "*.dashboard.lookml"  # include all dashboards in this project
include: "dims.lkml"     #include definitions from main model

label: "Qualtrics Surveys"

explore: magellandatagj {
  extends: [dim_course]
  fields: [ALL_FIELDS*, -fact_siteusage.time_on_task_to_final_score_correlation]
  label: "Gaurav Upload"
  join: dim_institution {
    sql_on: ${magellandatagj.entity_number} = ${dim_institution.entity_no};;
    relationship: many_to_one
  }
  join: dim_product {
    sql_on: ${magellandatagj.isbn_13} = ${dim_product.isbn13} ;;
    relationship: many_to_one
  }

  join: dim_course {
    sql_on: ${dim_product.productid} = ${dim_course.productid}
        and ${dim_institution.institutionid} = ${dim_course.institutionid};;
        relationship: one_to_many
  }

  join: fact_siteusage {
    sql_on: ${dim_course.courseid} = ${fact_siteusage.courseid} ;;
    relationship: one_to_many
  }

}
