class Order::Item::PriceChangeNotification < ApplicationRecord
  belongs_to :order_item
end
