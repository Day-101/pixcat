Item.destroy_all
puts "Database has been cleaned up."
20.times do
  cat_item = Item.new(
    title: Faker::Creature::Cat.name,
    description: Faker::Creature::Cat.breed,
    price: Faker::Number.decimal(l_digits: 2),
  )
  cat_item.save
  url = URI.parse(Faker::LoremFlickr.image(size: "1280x720"))
  filename = cat_item.id
  file = URI.open(url)
  cat_item.cat_picture.attach(io: file, filename: filename)
  cat_item.save
end
puts "20 items have been created"
