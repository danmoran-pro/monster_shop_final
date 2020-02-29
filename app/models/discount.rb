class Discount < ApplicationRecord
  belongs_to :merchant
  belongs_to :item
  
  # has_many :orders
  validates_presence_of :name, :percent_off, :quanity,

  validates_numericality_of :quanity
                            :percent_off, greater_than: 0, less_than: 1
end
