# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@admin.com', password: 'password')

# genre
genre_names = [
  'ケーキ',
  'キャンディ',
  'プリン',
  '焼き菓子'
]

genre_names.each do |genre_name|
  Genre.create!(
    name: genre_name,
    is_active: true
  )
end
# genre/

4.times do |n|
    Product.create!(
        genre_id: 1,
        name: "1",
        description: "sample text",
        price: 500,
        is_active: true
    )
end

