require 'rails_helper'

describe "as a admin merchant" do
  before(:each) do 
    @merchant_1 = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)
    @item_1 = @merchant_1.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 30, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 45, active: true )
    @item_2 = @merchant_1.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 35, active: true )
    @item_3 = @merchant_1.items.create(name: "Baby Yoda", description: "Baby Yoda", price: 1000000000, image: 'https://www.htxt.co.za/wp-content/uploads/2020/02/75317-The-Mandalorian-The-Child-H-LEGO.png', inventory: 1, active: true )
    @discount_1 = @item_1.discounts.create!(name: "bulk20", quantity: 20, percentage_off: 0.25, merchant_id: @merchant_1.id )
    @discount_2 = @item_2.discounts.create!(name: "bulk30", quantity: 30, percentage_off: 0.30, merchant_id: @merchant_1.id )
    @user = create(:merchant_admin, merchant: @merchant_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end 
  describe "When I visit an discount's index page" do
    it " I see an edit button under each discount that directs me to an edit form" do 

      visit "/merchant/discounts"
      
      within "#discount-#{@discount_1.id}" do 
        expect(page).to have_content(@discount_1.name)
        expect(page).to have_content(@discount_1.quantity)
        expect(page).to have_content(@discount_1.percentage_off)
        expect(page).to have_button("Edit Discount")
      end 

      within "#discount-#{@discount_2.id}" do 
        expect(page).to have_content(@discount_2.name)
        expect(page).to have_content(@discount_2.quantity)
        expect(page).to have_content(@discount_2.percentage_off)
        click_button("Edit Discount")
      end 

      expect(current_path).to eq("/merchant/items/#{@item_2.id}/discounts/#{@discount_2.id}/edit") 
    end

    it "Can an existing discount" do 
      visit "/merchant/items/#{@item_2.id}/discounts/#{@discount_2.id}/edit"


      name = 'bulk10'
      quantity = 10
      percentage_off = 0.15

      fill_in 'Name', with: name
      fill_in 'Quantity', with: quantity
      fill_in 'percentage_off', with: percentage_off

      click_button 'Update Discount'

      expect(current_path).to eq("/merchant/discounts")

      within "#discount-#{@discount_2.id}" do 
        expect(page).to have_content("Discount Name: bulk10")
        expect(page).to have_content("Quantity Threshold: 10")
        expect(page).to have_content("Percentage Off: 0.15")
      end
    end

    it "clicking discount name from items index page takes me to a discount edit form" do
      visit merchant_items_path(@merchant_1)
      
      within "#item-#{@item_1.id}" do 
        click_link "bulk20"
      end

      expect(current_path).to eq("/merchant/items/#{@item_1.id}/discounts/#{@discount_1.id}/edit")
    end 
  end
end 

