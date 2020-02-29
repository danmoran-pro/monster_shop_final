require 'rails_helper'

describe "as a admin merchant" do
  before(:each) do 
    @merchant_1 = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)
    @item_1 = @merchant_1.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 30, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 1, active: true )
    @item_2 = @merchant_1.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 20, active: true )
    @item_3 = @merchant_1.items.create(name: "Baby Yoda", description: "Baby Yoda", price: 1000000000, image: 'https://www.htxt.co.za/wp-content/uploads/2020/02/75317-The-Mandalorian-The-Child-H-LEGO.png', inventory: 1, active: true )
    @user = create(:merchant_admin, merchant: @merchant_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end 
  describe "When I visit an item's show page" do
    it " I see a link to create a new coupon for that item" do 
      visit "/merchant/items"
      
      within "#item-#{@item_2.id}" do 
        click_on "New Coupon"
      end

      expect(current_path).to eq("/merchant/items/#{@item_2.id}/discounts/new")
    end 
  end
end


# As a visitor,
# When I visit an item's show page,
# I see a list of reviews for that item
# Each review will have:
# - title
# - content of the review
# - rating (1 to 5)