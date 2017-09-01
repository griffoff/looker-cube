connection: "snowflake_prod"

include: "*.view.lkml"
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "dims.model.lkml"     #include definitions from main model

label: "Qualtrics Surveys"

explore: magellandatagj {
  extends: [dim_course]
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
  }

}
