
# frozen_string_literal: true

Carousel.destroy_all
Photo.delete_all
Paragraph.delete_all
Page.delete_all

home_page = Page.create(name: 'home_page')

carousel = Carousel.create(name: 'home', page: home_page)

photo1 = Photo.create(remote_image_url: 'https://res.cloudinary.com/casal/image/upload/v1485865015/car1_t7w3fi.jpg',
                      photo_page: carousel)
photo2 = Photo.create(remote_image_url: 'https://res.cloudinary.com/casal/image/upload/v1485865012/car2_xz4nyb.jpg',
                      photo_page: carousel)
photo3 = Photo.create(remote_image_url: 'https://res.cloudinary.com/casal/image/upload/v1485865022/car3_tf1wts.jpg',
                      photo_page: carousel)

p1 = Paragraph.create(heading: 'Hello World', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel arcu elementum, pretium mi at, sodales turpis. Phasellus vel pellentesque sem. In hac habitasse platea dictumst. Nam pulvinar at neque posuere tempus. Donec efficitur vestibulum elit eu lobortis. Ut at aliquet orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis dui justo. Phasellus vitae commodo ipsum, nec laoreet justo. Sed ligula eros, congue at semper id, feugiat in ipsum. Proin pretium, nulla molestie commodo bibendum, sapien velit euismod mi, sit amet pretium leo lectus at mi. Maecenas dignissim et velit eu auctor. Duis enim mi, ullamcorper mattis sapien ut, dapibus tempus ante.', page: home_page)

p2 = Paragraph.create(text: 'Sed faucibus sodales euismod. Fusce blandit semper nunc non aliquet. Morbi at nunc quis nisl sodales imperdiet. Maecenas id tincidunt lectus. Donec pellentesque mollis purus, ut vehicula purus ornare quis. Donec dapibus iaculis augue, sed ornare erat vehicula malesuada. Sed metus diam, pharetra ut commodo a, lobortis nec mauris. Nulla ut est sed justo gravida porta. Duis vestibulum, leo id euismod volutpat, nibh mi molestie tellus, et volutpat urna ligula id ex.', page: home_page)

p3 = Paragraph.create(text: 'Nunc tincidunt feugiat dolor. Integer pretium risus eget augue gravida, nec euismod lectus sollicitudin. Pellentesque iaculis, tortor ut malesuada tincidunt, risus urna efficitur nulla, vitae gravida elit ipsum ac diam. Aliquam tincidunt eleifend arcu, vitae feugiat velit rhoncus non. Phasellus pulvinar ipsum non velit cursus porta. Phasellus non urna auctor, varius massa nec, tristique arcu. Praesent felis libero, dictum sit amet eros a, consectetur iaculis sem.', page: home_page)

# Admin User
User.destroy_all
User.create!(email: 'admin@example.com', password: 'foobar', password_confirmation: 'foobar')

# Prices
Price.destroy_all

Price.create!(start_date: '2016-10-29', end_date: '2017-03-31', min_days: 7,
              weekly_price: 1299.00, extra_price: 150.00, service_costs: 500.00)

Price.create!(start_date: '2017-04-01', end_date: '2017-06-23', min_days: 7,
              weekly_price: 1499.00, extra_price: 150.00, service_costs: 500.00)

Price.create!(start_date: '2017-06-24', end_date: '2017-09-01', min_days: 7,
              weekly_price: 2999.00, extra_price: 140.00, service_costs: 500.00,
              saturdays_only: true)

Price.create!(start_date: '2017-09-02', end_date: '2017-11-03', min_days: 7,
              weekly_price: 1499.00, extra_price: 150.00, service_costs: 500.00)

Price.create!(start_date: '2017-11-04', end_date: '2018-03-31', min_days: 7,
              weekly_price: 1299.00, extra_price: 150.00, service_costs: 500.00)

# Booking
Booking.destroy_all

def createbooking(ci, co, cf, pa)
  Booking.new(
    check_in: ci,
    check_out: co,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: Faker::Name.prefix,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    street_name: Faker::Address.street_name,
    street_number: Faker::Number.number(2).to_s,
    city: Faker::Address.city,
    zip_code: Faker::Address.zip_code,
    people: rand(10) + 5,
    confirmed: cf,
    paid: pa
  ).save(validate: false)
end

createbooking(14.days.ago, 7.days.ago, true, true)
createbooking(Date.today, Date.today.advance(days: 7), true, true)
createbooking(Date.today.advance(weeks: 3), Date.today.advance(weeks: 4), true, false)
createbooking(Date.today.advance(months: 2), Date.today.advance(months: 2, weeks: 1), false, false)

# Reviews
Review.destroy_all

Review.create!(name: 'Stefan', stars: 5, review: "It was the most impressive location I've ever been to.")
Review.create!(name: 'Andrew', stars: 5, review: 'This was incredible.')
Review.create!(name: 'Sander', stars: 4, review: 'Really cool place. Too bad the wifi was bad.')
Review.create!(name: 'Thanos', stars: 4, review: 'Amazing. But not Greece.')
Review.create!(name: 'Jeroen', stars: 5, review: 'Beautifully designed place.')
Review.create!(name: 'Vincent', stars: 4, review: 'The bars in the area are great. Beautiful house as well.')
