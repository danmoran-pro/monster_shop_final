require 'rails_helper'

describe "can create bots" do
  it "create it" do 
    merchant_1 = create(:random_merchant)
    item_1 = create(:random_item, merchant_id: merchant_1.id)
    user = create(:default)
    merchant_admin = create(:merchant_admin, merchant_id: merchant_1.id )
    admin = create(:admin)
  end 
end
