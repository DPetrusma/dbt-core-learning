{{ dbt_utils.date_spine(
        datepart="day",
        start_date="TO_DATE('2020-01-01', 'yyyy-mm-dd')",
        end_date="TO_DATE('2020-12-31', 'yyyy-mm-dd')"
    )
}}