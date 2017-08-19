
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

p1 = Paragraph.create(heading: 'Rust, natuurschoon, privacy in het hartje van het Chianti gebied in Toscane',
text: 'Onze villa, gelegen op loopafstand van Tregole in het beroemde wijngebied van de Chianti Classico, beschikt over vijf royale slaapkamers en drie badkamers. De villa ligt centraal tussen wijngaarden, olijfbomen en bossen waardoor u in een gebied verblijft van privacy, rust en natuurschoon. In de tuin is een groot zwembad, een kinderspeelplaats, verschillende terrassen (met zon en schaduwplekken). Allen met een prachtig uitzicht! Wanneer u gezamenlijk wilt dineren kunt u de pizza-oven of de barbecue in de arcade gebruiken om heerlijke gerechten uit het lokale gebied klaar te maken, waarna u het kunt serveren op de lange Toscaanse tafel. De omgeving is veilig voor kinderen. Deze luxe locatie is geschikt voor maximaal 16 personen en beschikt over faciliteiten die het verblijf een stuk leuker en gemakkelijk maken. ', page: home_page)

p2 = Paragraph.create(text: 'Het op loopafstand gelegen Tregole is een klein gehucht zonder winkels, maar de nabij gelegen steden, zoals Castellina in Chianti, Siena en Florence zijn goed te bereiken met de auto of de fiets. Afstanden: Tregole 500m, Castellina in Chianti (onder meer supermarkt, restaurants, bars, dokter, apotheek, kerk) 3km, San Gimignano 22km, Siena 24km, Florence 35km', page: home_page)

p3 = Paragraph.create(text: 'Qua mountainbiken en wielrennen is deze omgeving perfect: prachtige wegen, afwisselende klims en mooie vergezichten gecombineerd met historische dorpjes en steden. De buren, Brancaia en Fonterutoli, verkopen één van de beste wijnen van Italië, die waarschijnlijk goed zullen aansluiten bij het zelf klaargemaakte diner. Mocht u zelf niet willen koken; onze beheerder is gediplomeerd kok. Met hem kunt u afspraken maken over een Toscaanse kookworkshop, een pizza-avond of zelfs een gehele lokale maaltijd laten verzorgen.', page: home_page)

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

Review.create!(name: 'Stefan', stars: 5, review: "Een indrukwekkende locatie en heerlijk eten.")
Review.create!(name: 'Andrew', stars: 5, review: 'Fantastisch')
Review.create!(name: 'Sander', stars: 4, review: 'Cool. Jammer dat de wifi het niet zo goed was.')
Review.create!(name: 'Thanos', stars: 4, review: 'Prachtig, maar geen Griekenland.')
Review.create!(name: 'Jeroen', stars: 5, review: 'Klassieke villa in een prachtige streek.')
Review.create!(name: 'Vincent', stars: 4, review: 'De lokale service is goed en je kunt fijn wandelen.')
