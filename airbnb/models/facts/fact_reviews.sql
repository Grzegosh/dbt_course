{{
    config(
        materialized = 'incremental',
        on_schema_change = 'append_new_columns'
    )
}}
WITH src_reviews AS (

    SELECT
        *
    FROM
        {{ref('src_reviews')}}
)
SELECT
    {{ dbt_utils.generate_surrogate_key((["review_date","listing_id","review_text"]))}} As review_id,
    *
FROM
    src_reviews
WHERE
    review_text IS NOT NULL

{% if is_incremental() %}
    AND review_date > (SELECT MAX(review_date) FROM {{this}})
{% endif %}