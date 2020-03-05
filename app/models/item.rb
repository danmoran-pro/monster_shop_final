class Item < ApplicationRecord
  belongs_to :merchant
  has_many :discounts
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def self.active_items
    where(active: true)
  end

  def self.by_popularity(limit = nil, order = "DESC")
    left_joins(:order_items)
    .select('items.id, items.name, COALESCE(sum(order_items.quantity), 0) AS total_sold')
    .group(:id)
    .order("total_sold #{order}")
    .limit(limit)
  end

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def discounted_price(quantity)
    if self.discounts.where("quantity <= ?", quantity).order("percentage_off DESC").limit(1) != []
      discount = self.discounts.where("quantity <= ?", quantity).order("percentage_off DESC").limit(1).first.percentage_off.to_f * price
      price - discount
    else 
      price
    end
  end 
end

# discount = (self.discounts.order(percentage_off: :desc)).first.percentage_off.to_f * price