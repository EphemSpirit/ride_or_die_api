100.times do
  Movie.create!(title: Faker::Movie.title,
                description: Faker::Lorem.paragraph(sentence_count: 5),
                rating: Faker::Number.decimal(l_digits: 1))
end
