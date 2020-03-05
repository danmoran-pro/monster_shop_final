require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Create Order' do
  describe 'As a Registered User' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @user = User.create!(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click a link to get to create an order' do
      visit item_path(@ogre)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'

      visit '/cart'

      click_button 'Check Out'

      order = Order.last

      expect(current_path).to eq('/profile/orders')
      expect(page).to have_content('Order created successfully!')
      expect(page).to have_link('Cart: 0')

      within "#order-#{order.id}" do
        expect(page).to have_link(order.id)
      end
    end
  end

  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it "I see a link to log in or register to check out" do
      visit item_path(@ogre)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'
      visit item_path(@hippo)
      click_button 'Add to Cart'

      visit '/cart'

      expect(page).to_not have_button('Check Out')

      within '#checkout' do
        click_link 'register'
      end

      expect(current_path).to eq(registration_path)

      visit '/cart'

      within '#checkout' do
        click_link 'log in'
      end

      expect(current_path).to eq(login_path)
    end
  end

  describe 'As a User' do
    before :each do
      @merchant_1 = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)
      @item_1 = @merchant_1.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 5, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 60, active: true )
      @item_2 = @merchant_1.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 35, active: true )
      @discount_1 = @item_1.discounts.create!(name: "bulk20", quantity: 20, percentage_off: 0.05, merchant_id: @merchant_1.id )
      @user = User.create!(name: 'Danny', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'danny@example.com', password: 'securepassword')
      @order_1 = @user.orders.create!(status: "packaged")
      @order_2 = @user.orders.create!(status: "packaged")
      @order_3 = @user.orders.create!(status: "packaged")
      @order_item_1 = @order_1.order_items.create!(item: @item_1, price: @item_1.price, quantity: 19, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item: @item_1, price: 4.75, quantity: 20, fulfilled: true)
      @order_item_3 = @order_3.order_items.create!(item: @item_1, price: 4.75, quantity: 20, fulfilled: true)
      @order_item_4 = @order_3.order_items.create!(item: @item_1, price: @item_2.price, quantity: 1, fulfilled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see order information on WITH Discount applied' do
      visit "/profile/orders"


      within "#order-#{@order_1.id}" do
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content("Created On: #{@order_1.created_at}")
        expect(page).to have_content("Updated On: #{@order_1.updated_at}")
        expect(page).to have_content("Status: #{@order_1.status}")
        expect(page).to have_content("#{@order_1.count_of_items} items")
        expect(page).to have_content("Total: $95.00")
      end
      
      within "#order-#{@order_2.id}" do
        expect(page).to have_link(@order_2.id)
        expect(page).to have_content("Created On: #{@order_2.created_at}")
        expect(page).to have_content("Updated On: #{@order_2.updated_at}")
        expect(page).to have_content("Status: #{@order_2.status}")
        expect(page).to have_content("#{@order_2.count_of_items} items")
        expect(page).to have_content("Total: $95.00")
      end

    end

    igst "see discounted price within show page" do 
      visit "/profile/orders/#{@order_3.id}"


      expect(page).to have_content(@order_3.id)
      expect(page).to have_content("Created On: #{@order_3.created_at}")
      expect(page).to have_content("Updated On: #{@order_3.updated_at}")
      expect(page).to have_content("Status: #{@order_3.status}")
      expect(page).to have_content("#{@order_3.count_of_items} items")
      expect(page).to have_content("Total: #{number_to_currency(@order_3.grand_total)}")
      
      within "#order-item-#{@order_item_3.id}" do
        expect(page).to have_link(@order_item_3.item.name)
        expect(page).to have_content(@order_item_3.item.description)
        expect(page).to have_content(@order_item_3.quantity)
        expect(page).to have_content(@order_item_3.price)
        expect(page).to have_content(@order_item_3.subtotal)
      end

      within "#order-item-#{@order_item_4.id}" do
        expect(page).to have_link(@order_item_4.item.name)
        expect(page).to have_content(@order_item_4.item.description)
        expect(page).to have_content(@order_item_4.quantity)
        expect(page).to have_content(@order_item_4.price)
        expect(page).to have_content(@order_item_4.subtotal)
      end
      save_and_open_page
    end 
  end
end
