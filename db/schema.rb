# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160128190630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "available"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_inventories_on_product_id", using: :btree
  end

  create_table "order_item_price_change_notifications", force: :cascade do |t|
    t.integer  "order_item_id"
    t.money    "difference",      scale: 2
    t.datetime "acknowledged_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["order_item_id"], name: "index_order_item_price_change_notifications_on_order_item_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.money    "price",       scale: 2
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "shipment_id"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
    t.index ["shipment_id"], name: "index_order_items_on_shipment_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.money    "net",            scale: 2
    t.money    "processing_fee", scale: 2
    t.money    "subtotal",       scale: 2
    t.money    "shipping_fee",   scale: 2
    t.money    "tax",            scale: 2
    t.money    "total",          scale: 2
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "product_categorizations", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_product_categorizations_on_category_id", using: :btree
    t.index ["product_id", "category_id"], name: "index_product_categorizations_on_product_id_and_category_id", unique: true, using: :btree
    t.index ["product_id"], name: "index_product_categorizations_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.money    "price",       scale: 2
    t.integer  "position"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shipments_on_order_id", using: :btree
  end

  create_table "transitions", force: :cascade do |t|
    t.string   "to_state"
    t.json     "metadata"
    t.integer  "sort_key"
    t.string   "stateful_type"
    t.integer  "stateful_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["stateful_type", "stateful_id"], name: "index_transitions_on_stateful_type_and_stateful_id", using: :btree
  end

  add_foreign_key "inventories", "products"
  add_foreign_key "order_item_price_change_notifications", "order_items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_items", "shipments"
  add_foreign_key "product_categorizations", "categories"
  add_foreign_key "product_categorizations", "products"
  add_foreign_key "shipments", "orders"

  create_view :product_listings,  sql_definition: <<-SQL
      WITH listings AS (
           SELECT products.id,
              products.name,
              products.description,
              products.price,
              products."position",
              products.created_at,
              products.updated_at,
              categories.name AS category
             FROM ((product_categorizations pc
               LEFT JOIN products ON ((products.id = pc.product_id)))
               LEFT JOIN categories ON ((pc.category_id = categories.id)))
          UNION
           SELECT products.id,
              products.name,
              products.description,
              products.price,
              products."position",
              products.created_at,
              products.updated_at,
              NULL::character varying AS category
             FROM products
          )
   SELECT listings.id,
      listings.name,
      listings.description,
      listings.price,
      listings.category,
          CASE inventories.available
              WHEN NULL::integer THEN false
              ELSE (sum(inventories.available) <= sum(order_items.id))
          END AS sold_out
     FROM (((listings
       LEFT JOIN inventories ON ((inventories.product_id = listings.id)))
       LEFT JOIN order_items ON ((order_items.product_id = listings.id)))
       LEFT JOIN transitions ON (((transitions.stateful_id = order_items.id) AND ((transitions.stateful_type)::text = 'Order::Item'::text))))
    GROUP BY listings.id, listings.category, listings.name, listings.description, listings.price, inventories.available, listings."position"
    ORDER BY listings."position";
  SQL
end
