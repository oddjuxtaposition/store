-- category_listings_v01

     SELECT categories.name 
       FROM categories
      WHERE EXISTS ( SELECT 1 
                       FROM product_listings p
                      WHERE p.category = categories.name )

