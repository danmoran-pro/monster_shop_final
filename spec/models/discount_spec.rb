require 'rails_helper'

RSpec.describe Discount do
  describe 'validations' do
    it {should validate_presence_of :name}
    # it {should validate_presence_of :quantity  }
    # it {should validate_presence_of :percentage_off }

    it {should validate_numericality_of :quantity}
    it {should validate_numericality_of :percentage_off}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should belong_to :item}
  end
end 