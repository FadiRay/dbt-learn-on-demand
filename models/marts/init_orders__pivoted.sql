{% set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

with
payments as (
   select * from {{ ref('stg_jaffle_shop__customers') }}
),

final as (
    order_id,
    {% for payment_method in payment_methods -%}
    sum(case payment_methode = '{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount
    {%- if not loop.last -%}
    ,
    {% endif -%}
    {% endfor -%}

)

select * from final


