require 'rails_helper'

describe "as a admin merchant" do
  before(:each) do 
    @merchant_1 = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)
    @merchant_2 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @item_1 = @merchant_1.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 5, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 60, active: true )
    @item_2 = @merchant_1.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 35, active: true )

    @item_3 = @merchant_2.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
    @item_4 = @merchant_2.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
      
    
    @discount_1 = @item_1.discounts.create!(name: "bulk20", quantity: 20, percentage_off: 0.05, merchant_id: @merchant_1.id )
    @user = User.create!(name: 'Danny', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'danny@example.com', password: 'securepassword')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end 
  it "discount is applied after meething threshold " do 
    visit item_path(@item_1)
    click_button 'Add to Cart'
  
    visit '/cart'
  
    18.times do
      click_button('More of This!')
    end
  
  
  
    expect(page).to have_content('Cart: 19')
    expect(page).to have_content("Subtotal: $95.00")
  
    click_button('More of This!')
  
    expect(page).to have_content('Cart: 20')
    expect(page).to have_content('Price: $4.75')
    expect(page).to have_content("Subtotal: $95.00")
    expect(page).to have_content("Total: $100.00")
    save_and_open_page
    expect(page).to have_content("Discounted Total: $95.00")
  end 
  
  # it "greater discount is applied after meething threshold " do 
  #   discount_2 = @item_1.discounts.create!(name: "bulk05", quantity: 2, percentage_off: 0.05, merchant_id: @merchant_1.id )
  #   discount_3 = @item_1.discounts.create!(name: "bulk10", quantity: 3, percentage_off: 0.1, merchant_id: @merchant_1.id )
    
  #   visit item_path(@item_1)
  #   click_button 'Add to Cart'
    
  #   visit '/cart'
  #   save_and_open_page
    
  #   1.times do
  #     click_button('More of This!')
  #   end
    
  #   save_and_open_page
  #   # expect(page).to have_content('Cart: 20')
  #   # expect(page).to have_content('Price: $4.75')
  #   # expect(page).to have_content("Subtotal: $95.00")
  #   # expect(page).to have_content("Total: $100.00")
  #   # expect(page).to have_content("Discounted Total: $95.00")
    
  #   1.times do
  #     click_button('More of This!')
  #   end
    
  #   # expect(page).to have_content('Cart: 30')
  #   save_and_open_page
  #   # expect(page).to have_content('Price: $4.75') #this should be a smaller number due to bigger percentage
  #   # expect(page).to have_content("Subtotal: $135.00")
  #   # expect(page).to have_content("Total: $150.00")
  #   # expect(page).to have_content("Discounted Total: $135.00")
    
  # end 
end 
