class Discount < ApplicationRecord
  belongs_to :merchant
  belongs_to :item
  
  validates_presence_of :name, length: {in: 4..6}
                        # :percentage_off
                        # :quantity

  validates_numericality_of :quantity, length: {is: 20} 
  validates_numericality_of :percentage_off, length: {is: 0.25} 
                            # :percentage_off, greater_than: 0, less_than: 1
end
