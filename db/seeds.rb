Item.destroy_all
puts "Database has been cleaned up."
20.times do
  Item.create(
    title: Faker::Creature::Cat.name,
    description: Faker::Creature::Cat.breed,
    price: Faker::Number.decimal(l_digits: 2),
    image_url: "https://loremflickr.com/800/600/cat"
  )
end
puts "20 items have been created"
