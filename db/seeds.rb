# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# admin
Admin.create(email: 'admin@admin.com', password: 'password')
# admin/

# user
[
  ['test1@test.com', 'てすと', '太郎', 'テスト', 'タロウ', '1112222', '北海道', '11122223333'],
  ['test2@test.com', 'てすと', '花子', 'テスト', 'ハナコ', '3334444', '青森県', '44455556666'],
  ['test3@test.com', 'てすと', '太子', 'テスト', 'タコ', '5556666', '秋田県', '77788889999']
].each do |email, first_name, last_name, first_name_kana, last_name_kana, zip_code, address, phone_number|
  User.create!(
    first_name: first_name,
    last_name: last_name,
    first_name_kana: first_name_kana,
    last_name_kana: last_name_kana,
    email: email,
    zip_code: zip_code,
    address: address,
    phone_number: phone_number,
    password: "password"
  )
end
# user/

# genre
genre_names = ['ケーキ','キャンディ','プリン','焼き菓子']
genre_names.each do |genre_name|
  Genre.create!(
    name: genre_name,
    is_active: [true, false].sample
  )
end
# genre/

# product
32.times do |n|
    Product.create!(
        genre_id: rand(1..4),
        name: "サンプル商品#{n + 1}",
        description: "sample text#{n + 1}",
        price: [300, 400, 500].sample,
        is_active: [true, false].sample
    )
end
# product/

# user2
User.find_each do |user|
  # delivery
  3.times do |num|
    Delivery.create!(
      user_id: user.id,
      zip_code: [9998888, 7776666, 5554444].sample,
      address: "東京都新宿区◯◯ △丁目□-×",
      name: "サンプル宛先"
    )
  end
  # delivery/
  # order
  rand(1..3).times do |num|
    Order.create!(
      user_id: user.id,
      pay_method: [0, 1].sample,
      zip_code: [9998888, 7776666, 5554444].sample,
      address: "東京都新宿区◯◯ △丁目□-×",
      name: "サンプル宛先",
      total_price: 3000
    )
  end
  # orderの作成日を10日前～今日までの期間でばらけさせる
  Order.all.each do |order|
    order.update(created_at: (rand*10).days.ago)
  end
  # order/
  # cart_item
  3.times do |num|
    CartItem.create!(
      user_id: User.all.sample.id,
      product_id: Product.all.sample.id,
      amount: rand(1..4)
    )
  end
  # cart _tem/

end
# user2/

# order2
Order.find_each do |order|
  # order_product
  rand(1..5).times do |num|
  OrderProduct.create!(
    order_id: order.id,
    product_id: Product.all.sample.id,
    taxed_product_price: 0,
    amount: rand(1..10),
    production_status: 0
  )
  end
  # order_product/
end
# order2/

# order_productの支払い金額（taxed_product_priceを計算させる）
OrderProduct.all.each do |order_product|
  order_product.update(taxed_product_price: order_product.product.taxed_price)
end

Order.all.each do |order|
  total = 0
  order.order_products.each do |order_product|
    total = order_product.subtotal
  end
  Order.update(total_price: total + order.postage)
end