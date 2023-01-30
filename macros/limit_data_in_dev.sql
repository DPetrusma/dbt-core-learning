{% macro limit_data_in_dev(timestamp_column,cutoff_days=3)%}
    {% if target.name == 'dev' %}
    where {{timestamp_column}} >= dateadd( 'day', -{{cutoff_days}}, current_timestamp)
    {% endif%}
{% endmacro %}

{% macro date_spine()%}
    where datespine = 1
{% endmacro%}