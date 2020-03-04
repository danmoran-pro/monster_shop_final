class Discount < ApplicationRecord
  belongs_to :merchant
  belongs_to :item
  
  validates_presence_of :name, length: { in: 4..6 }
                        # :percentage_off
                        # :quantity

  validates_numericality_of :quantity, length: { in: 20..30 } 
  validates_numericality_of :percentage_off, length: { in: 0.25..0.99 }
end
