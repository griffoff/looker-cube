  view: mt_courses_fall2020 {
    derived_table: {
      explore_source: LP_Siteusage_Analysis {
        column: count { field: dim_course.count }
        column: governmentdefinedacademicterm { field: dim_start_date.governmentdefinedacademicterm }
        column: course_key { field: olr_courses.course_key }
        filters: {
          field: dim_institution.HED_filter
          value: "Yes"
        }
        filters: {
          field: dim_filter.is_external
          value: "Yes"
        }
        filters: {
          field: dim_party.is_external
          value: "Yes"
        }
        filters: {
          field: dim_start_date.governmentdefinedacademicterm
          value: "Fall 2020"
        }
      }
    }
    dimension: count {
      label: "Course / Section Details # Course Sections"
      description: "Count of course sections."
      type: number
    }
    dimension: governmentdefinedacademicterm {
      label: "Course / Section Details Academic Term"
      description: "Fall = August (8/1) - December (12/31).  Spring = January (1/1) - June (6/30).  Summer = July (7/1-7/31)
      This dimension represents a specific term in a specific year i.e. Fall 2017, not Fall"
    }
    dimension: course_key {
      label: "Course / Section Details Course Key"
    }

    measure: count_courses {
      type: count
      label: "# courses"
    }
  }
