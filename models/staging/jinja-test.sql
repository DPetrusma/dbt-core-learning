{% set player_count = ['2','3','4','5','6']-%}

with payments as (
    select * from {{ ref('stg_games') }}
),
pivoted as (
    select
        min_players,        
        {%- for pc in player_count %}
            avg( case when max_players = {{ pc }} then dylan_rating else null end ) as dr{{ pc}}p{% if not loop.last%},{% endif %}
        {%- endfor -%}
        {# avg( case when max_players = 2 then dylan_rating else null end ) as dr2p,
        avg( case when max_players = 3 then dylan_rating else null end ) as dr3p,
        avg( case when max_players = 4 then dylan_rating else null end ) as dr4p,
        avg( case when max_players = 5 then dylan_rating else null end ) as dr5p,
        avg( case when max_players = 6 then dylan_rating else null end ) as dr6p #}
    from payments
    group by
        min_players
)

select * from pivoted order by min_players