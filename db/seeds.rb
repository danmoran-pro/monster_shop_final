# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchant 
merchant_1 = Merchant.create(name: "Meg's Random Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
merchant_2 = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
merchant_3 = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)


#bike_shop items
item_1 = merchant_1.items.create!(name: "Tire", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, active: true )
item_2 = merchant_1.items.create!(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, active: true )
item_3 = merchant_1.items.create!(name: "Gnawt-A-Rock", description: "Holds treats", price: 100, image: "https://www.rei.com/media/252b0d74-f3cc-4b9d-8a7f-596440dfcc6c?size=784x588", inventory: 12, active: true )
item_4 = merchant_1.items.create!(name: "Gnawt-A-Stick", description: "Stays upright", price: 100, image: "https://www.rei.com/media/40d8402b-8415-4cab-a9fd-eba14298527d?size=784x588", inventory: 12, active: true )
item_5 = merchant_1.items.create!(name: "Hydro Plane", description: "Maintains shape", price: 100, image: "https://www.rei.com/media/be369a77-4a9b-426a-b67a-12649856fb9c?size=784x588", inventory: 12,active: true )

#dog_shop_items
item_6  = merchant_2.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, active: true )
item_7  = merchant_2.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active: false, inventory: 21 )
item_8  = merchant_2.items.create!(name: "Soft Disc", description: "Soft and durable", price: 10, image: "https://www.rei.com/media/beb5df0b-0763-48ce-b487-7522a5b6a929", inventory: 32, active: true )
item_9  = merchant_2.items.create!(name: "Huck-A_Cone", description: "Natural rubber", price: 10, image: "https://www.rei.com/media/71216e9a-fa1b-4dd0-a380-498ac5778894?size=784x588", inventory: 32, active: true )
item_10 = merchant_2.items.create!(name: "Pacific Loop", description: "Wide set handles", price: 10, image: "https://www.rei.com/media/fc850ada-324b-49c3-b15b-348ae246165f?size=784x588", inventory: 32, active: true )
item_11 = merchant_2.items.create!(name: "Collapsible Thrower", description: "Glows in the dark", price: 10, image: "https://www.rei.com/media/9ee5b433-dd30-4b29-923c-901e509e256b?size=784x588", inventory: 32, active: true )

#leggo shop
item_12 = merchant_3.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 30, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 1, active: true )
item_13 = merchant_3.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 20, active: true )
item_14 = merchant_3.items.create(name: "Baby Yoda", description: "Baby Yoda", price: 1000000000, image: 'https://www.htxt.co.za/wp-content/uploads/2020/02/75317-The-Mandalorian-The-Child-H-LEGO.png', inventory: 1, active: true )
item_15 = merchant_3.items.create(name: "Nintendo 64", description: "Best gaming machine of the century", price: 300, inventory: 3, active: false )

#users
user_1 = User.create!(name: "Benji Wolf", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443", email: "mrcool@gmail.com", password: "rh23489", role: 0)

#merchant_admin
merchant_1 = User.create!(name: "Danny Moron", address: "456 Uncool St", city: "Colorado Springs", state: "CO", zip: "54239", email: "uncannydanny@4realz.com", password: "t4389", role: 1, merchant: merchant_3)
merchant_2 = User.create!(name: "Danny Moron", address: "456 Uncool St", city: "Colorado Springs", state: "CO", zip: "54239", email: "dannythemanny@myspace.com", password: "t4389", role: 1, merchant: merchant_2)

#admin
admin = User.create!(name: "Zeke Fleek", address: "23832 Harbor Ave", city: "Boulder", state: "CO", zip: "54239", email: "zekeefleeky@altavista.com", password: "feqnu", role: 2)

