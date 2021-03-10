Item.destroy_all
puts "Database has been cleaned up."
20.times do
  cat_item = Item.new(
    title: Faker::Creature::Cat.name,
    description: Faker::Creature::Cat.breed,
    price: Faker::Number.decimal(l_digits: 2),
    image_url: "https://loremflickr.com/800/600/cat"
  )

  url = URI.parse(Faker::LoremFlickr.image(size: "1280x720"))
  filename = url.path
  file = URI.open(url)
  cat_item.cat_picture.attach(io: file, filename: filename)
  cat_item.save
end
puts "20 items have been created"
