- dashboard: student_activity_usage
  title: 'Student: Activity Usage'
  layout: newspaper
  elements:
#   - name: HOW TO USE THIS DASHBOARD
#     type: text
#     title_text: HOW TO USE THIS DASHBOARD
#     subtitle_text: ''
#     body_text: |-
#       1) Find the template dashboard most appropriate for the identified need
#
#       2) Click the 3 vertical dots and select “Explore from here” (right click to ensure it opens in a new browser tab)
#
#       3) Update filters as desired
#
#       4) Save updated looks and/or download tables to Excel
#     row: 0
#     col: 16
#     width: 8
#     height: 5
#   - name: NOTES
#     type: text
#     title_text: NOTES
#     body_text: |-
#       1) Figures are a percent of total activations for a given product family and edition within a fiscal year.  FY17 is the default.
#
#       2) Data is updated nightly, but has a 24+ hour delay (meaning, if you are looking on 8/10, data for 8/8 will be available, but data for 8/9 will NOT be available).
#
#       3) Activations figures are being updated and may move up or down a couple percentage points but should not impact analysis.
#     row: 0
#     col: 8
#     width: 8
#     height: 5
  - name: Usage Data Template - Overview
    title: Usage Data Template - Overview
    model: cube
    explore: fact_activation
    type: looker_single_record
    fields:
    - dim_product.productfamily
    - dim_product.edition
    - product_facts.product_users
    - fact_activation.user_count
    - fact_activation.total_noofactivations
    - product_facts.activations_for_isbn
    - fact_activation.course_count
    - fact_activation.institution_count
    filters:
      dim_institution.HED_filter: 'Yes'
      dim_filter.is_external: 'Yes'
      dim_party.is_external: 'Yes'
      dim_start_date.fiscalyear: FY17
      dim_institution.country: UNITED STATES
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
    sorts:
    - product_facts.product_users desc
    limit: 500
    column_limit: 50
    show_view_names: true
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - product_facts.activations_for_isbn
    listen:
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    row: 0
    col: 0
    width: 10
    height: 4

    #######################################################################################
  - title: Activity Type Usage - Percent of Users
    name: Activity Type Usage - Percent of Users
    model: cube
    explore: fact_siteusage
    type: looker_bar
    fields:
    - fact_siteusage.usercount
    - product_facts.activations_for_isbn
    - activity_usage_facts.activity_type_usage_bucket
    - mindtap_lp_activity_tags.activity_usage_facts_grouping
    pivots:
    - activity_usage_facts.activity_type_usage_bucket
    filters:
      dim_filter.is_external: 'Yes'
      dim_party.is_external: 'Yes'
      ipeds.institution_name: ''
      dim_learningpath.learningtype: Activity
      dim_learningpath.snapshot_status: Core item
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      dim_user.user_role: Student
    filter: selected_activity
    suggest_dimension: activity_usage_facts_grouping
    dimension: activity_type
    sorts:
    - activity_usage_facts.activity_type_usage_bucket desc 0
    - mindtap_lp_activity_tags.activity_usage_facts_grouping desc
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: calculated_no_usage
      label: Calculated - No Usage
      expression: "${product_facts.activations_for_isbn:row_total} - ${fact_siteusage.usercount:row_total}"
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: number
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    series_types: {}
    hidden_series: []
    hidden_fields:
    - product_facts.activations_for_isbn
    series_colors:
      calculated_no_usage: "#e3704d"
      75%+ - 5 - fact_siteusage.usercount: "#a9c574"
      75% - 4 - fact_siteusage.usercount: "#62bad4"
    series_labels:
      75% - 4 - fact_siteusage.usercount: 50-74%
      50% - 3 - fact_siteusage.usercount: 25-49%
      25% - 2 - fact_siteusage.usercount: "< 25%"
      calculated_no_usage: No Usage
      One Time usage - 1 - fact_siteusage.usercount: Used Once
    x_axis_label: Activity Type
    listen:
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: expanded
    note_display: above
    note_text: 'Graph represents ACTIVITY TYPE USAGE as a percentage of total activations
      split into buckets based how many activities were usage as a percent of total
      activities available for a given type.  For example: if there are 15 "End-of-Chapter
      Quiz activities, a user who access 7 "End-of-Chapter" quizzes would fall into
      the  GREY "<50%": bucket.'
    row: 5
    col: 0
    width: 24
    height: 12
    ###################################################################################
  - title: Activity Type Usage - Percent Users - by Status
    name: Activity Type Usage - Percent Users - by Status
    model: cube
    explore: fact_siteusage
    type: looker_bar
    fields:
    - fact_siteusage.usercount
    - product_facts.activations_for_isbn
    - activity_usage_facts.activity_type_usage_bucket
    - mindtap_lp_activity_tags.activity_usage_facts_grouping
    pivots:
    - activity_usage_facts.activity_type_usage_bucket
    filters:
      dim_filter.is_external: 'Yes'
      dim_party.is_external: 'Yes'
      ipeds.institution_name: ''
      dim_learningpath.learningtype: Activity
      dim_activity.status: graded
      dim_learningpath.snapshot_status: Core item
      dim_product.productfamily_edition: Kearney/Abnormal Psychology & - 003
      dim_user.user_role: Student
    sorts:
    - activity_usage_facts.activity_type_usage_bucket desc 0
    - mindtap_lp_activity_tags.activity_usage_facts_grouping desc
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: calculated_no_usage
      label: Calculated - No Usage
      expression: "${product_facts.activations_for_isbn:row_total} - ${fact_siteusage.usercount:row_total}"
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: number
    stacking: percent
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    series_types: {}
    hidden_series: []
    hidden_fields:
    - product_facts.activations_for_isbn
    series_colors:
      calculated_no_usage: "#e3704d"
      75%+ - 5 - fact_siteusage.usercount: "#a9c574"
      75% - 4 - fact_siteusage.usercount: "#62bad4"
    series_labels:
      75% - 4 - fact_siteusage.usercount: 50-74%
      50% - 3 - fact_siteusage.usercount: 25-49%
      25% - 2 - fact_siteusage.usercount: "< 25%"
      calculated_no_usage: No Usage
      One Time usage - 1 - fact_siteusage.usercount: Used Once
    x_axis_label: Activity Type
    listen:
      Status: dim_activity.status
      Fiscal Year: dim_start_date.fiscalyear
      Product Family + Edition: dim_product.productfamily_edition
    note_state: collapsed
    note_display: above
    note_text: Same graph as above, but filtered ONLY for "status = graded" activities
      (so activity types such as Reading will not appear on this graph, as they cannot
      be graded).
    row:
    col:
    width:
    height:
  filters:
  - name: Status
    title: Status
    type: field_filter
    default_value: graded
    model: cube
    explore: fact_siteusage
    field: dim_activity.status
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Fiscal Year
    title: Fiscal Year
    type: field_filter
    default_value: FY17
    model: cube
    explore: fact_siteusage
    field: dim_start_date.fiscalyear
    listens_to_filters: []
    allow_multiple_values: true
    required: false
  - name: Product Family + Edition
    title: Product Family + Edition
    type: field_filter
    default_value: Kearney/Abnormal Psychology & - 003
    model: cube
    explore: fact_siteusage
    field: dim_product.productfamily_edition
    listens_to_filters: []
    allow_multiple_values: true
    required: false
