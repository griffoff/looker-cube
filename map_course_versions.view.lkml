view: map_course_versions {
  derived_table: {
    sql:
      with courses as (
        select begin_date, end_date, "#CONTEXT_ID" as context_id, last_updated_on
        from stg_clts.olr_courses_all
      )
      ,dates as (
        select context_id, begin_date::date as start_date, end_date::date as end_date
              ,min(last_updated_on) as first_seen
        from courses
        group by 1, 2, 3
        )
      ,diffs as (
        select
            *
            ,lead(start_date) over(partition by context_id order by first_seen) as next_start_date
            ,lead(end_date) over(partition by context_id order by first_seen) as next_end_date
            ,datediff(day, start_date, next_start_date) as start_date_movement
            ,datediff(day, end_date, next_end_date) as end_date_movement
            ,case when (start_date_movement > 7 and end_date_movement > 7) or next_start_date is null then 1 else 0 end as both_moved_ahead
            ,case when coalesce(datediff(day, start_date, next_start_date), 8) > 7 then 1 else 0 end as start_moved
        from dates
       )
      ,variants as (
        select
            row_number() over (partition by context_id order by start_date) as version_no
            ,*
        from diffs
        where both_moved_ahead = 1
      )
      ,v as (
        select
              *
              ,lead(first_seen) over (partition by context_id order by first_seen) as next_seen
              ,max(version_no) over (partition by context_id) as versions
        from variants
        )
      select distinct
          v.context_id
          ,v.version_no
          ,v.start_date
          ,v.end_date
          ,v.versions
          ,case when version_no = 1 then 0::timestamp else first_seen end as effective_from
          ,coalesce(dateadd(millisecond, -1, next_seen), '9999-12-31') as effective_to
      from v
      order by 1, 2, 3
      ;;
      sql_trigger_value: select count(*) ;;
  }
 }
