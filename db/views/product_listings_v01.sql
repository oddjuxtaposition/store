-- product_listings_v01
-- will return duplicate products, 
-- you will want to WHERE category = 'Coffee' or 
-- WHERE category IS NULL
WITH listings AS (
      SELECT products.*,
             categories.name as category
        FROM product_categorizations pc 
   LEFT JOIN products   ON products.id    = pc.product_id
   LEFT JOIN categories ON pc.category_id = categories.id

UNION 

      SELECT products.*,
             NULL as category
        FROM products
)

      SELECT listings.id,
             listings.name,
             listings.description,
             listings.price,
             listings.category,
             CASE inventories.available
             WHEN NULL THEN false
             ELSE
               SUM(inventories.available) <= SUM(order_items.id)
             END as sold_out

        FROM listings
   LEFT JOIN inventories  ON inventories.product_id    = listings.id
   LEFT JOIN order_items  ON order_items.product_id    = listings.id
   LEFT JOIN transitions  ON transitions.stateful_id   = order_items.id
                         AND transitions.stateful_type = 'Order::Item'

    GROUP BY listings.id, listings.category,
                listings.name, listings.description,
                listings.price, inventories.available,
                listings.position
    ORDER BY listings.position 

