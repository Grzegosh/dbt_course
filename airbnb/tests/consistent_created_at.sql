SELECT
    fct.*
FROM
    {{ref('fact_reviews')}} fct
JOIN
    {{ref('dim_listings_cleansed')}} dim
    ON fct.listing_id = dim.listing_id
WHERE
    fct.review_date < dim.created_at
LIMIT
    10