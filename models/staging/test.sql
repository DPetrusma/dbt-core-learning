{#
{% for i in range(10) %}

    select {{i}} as number {% if not loop.last %} union all {% endif %}

{% endfor %}

{% set my_cool_string = 'wow cool' %}

{{ my_cool_string }}

#}

{% set animals = ['lemur','lion','choobakbie'] %}
select '{{ animals[0] }}' as a