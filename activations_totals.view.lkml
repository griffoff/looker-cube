 view: activations_totals {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql:
       SELECT
              COUNT(distinct userid) as activated_users
       FROM dw_ga.fact_activation
       WHERE {% condition dim_product.productid %} activations_totals.productid {% endcondition %}
       AND {% condition dim_date.datekey %} activations_totals.activationdatekey {% endcondition %}
       AND {% condition dim_productplatform.productplatformid %} activations_totals.productplatformid {% endcondition %}
       ;;
   }

   measure: user_count {
     description: "Grand total # users activated"
     type: max
     sql: ${TABLE}.activated_users ;;
     #hidden: yes
   }
}
