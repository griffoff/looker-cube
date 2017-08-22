view: map_course_versions {
  derived_table: {
    sql:
      set min_days = 7;
      with dates as (
        select "#CONTEXT_ID", begin_date::date as start_date, end_date::date as end_date
              ,min(last_updated_on) as first_seen
        from olr_courses_all
        group by 1, 2, 3
        )
      ,diffs as (
        select
            *
            ,lead(start_date) over(partition by "#CONTEXT_ID" order by first_seen) as next_start_date
            ,lead(end_date) over(partition by "#CONTEXT_ID" order by first_seen) as next_end_date
            ,datediff(day, start_date, next_start_date) as start_date_movement
            ,datediff(day, end_date, next_end_date) as end_date_movement
            ,case when (start_date_movement > $min_days and end_date_movement > $min_days) or next_start_date is null then 1 else 0 end as both_moved_ahead
            ,case when coalesce(datediff(day, start_date, next_start_date), 8) > $min_days then 1 else 0 end as start_moved
        from dates
       )
      ,variants as (
        select
            row_number() over (partition by "#CONTEXT_ID" order by start_date) as version_no
            ,*
        from diffs
        where both_moved_ahead = 1
      )
      ,v as (
        select
              *
              ,lead(first_seen) over (partition by "#CONTEXT_ID" order by first_seen) as next_seen
              ,max(version_no) over (partition by "#CONTEXT_ID") as versions
        from variants
        )
      select distinct
          v."#CONTEXT_ID" as context_id
          ,v.version_no
          ,v.start_date
          ,v.end_date
          ,v.versions
          ,case when version_no = 1 then 0::timestamp else first_seen end as effective_from
          ,coalesce(dateadd(millisecond, -1, next_seen), '9999-12-31') as effective_to
      from v
      order by "#CONTEXT_ID", version_no, start_date
      ;;
      sql_trigger_value: select count(*) ;;
  }
 }
