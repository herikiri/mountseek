# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

items = [Type, Package, DisciplineOption, GenderOption, BreedOption, ColorOption, TemperamentOption, ExperienceOption, AiTypeOption]
items.each(&:delete_all)

Type.connection.execute('ALTER SEQUENCE types_id_seq RESTART WITH 1')
Package.connection.execute('ALTER SEQUENCE packages_id_seq RESTART WITH 1')
DisciplineOption.connection.execute('ALTER SEQUENCE disciplines_id_seq RESTART WITH 1')
GenderOption.connection.execute('ALTER SEQUENCE gender_options_id_seq RESTART WITH 1')
BreedOption.connection.execute('ALTER SEQUENCE breed_options_id_seq RESTART WITH 1')
ColorOption.connection.execute('ALTER SEQUENCE color_options_id_seq RESTART WITH 1')
TemperamentOption.connection.execute('ALTER SEQUENCE temperament_options_id_seq RESTART WITH 1')
ExperienceOption.connection.execute('ALTER SEQUENCE experience_options_id_seq RESTART WITH 1')
AiTypeOption.connection.execute('ALTER SEQUENCE ai_type_options_id_seq RESTART WITH 1')


horse = Type.create(name: "Horse")
stud = Type.create(name: "Stud")
tack = Type.create(name: "Tack")
trailer = Type.create(name: "Trailer")
real_estate = Type.create(name: "Real Estate")
my_service = Type.create(name: "Service")

genders = %w( Males Females Fillies Geldings Ridglings Stallions Uboarn Foals Broodmares Ridglings Weanlings Yearlings Folas Unknown ) 
breeds = ["Arabian", "Big Hair", "Colors & Spots", "Drafts Gaited", "Baroque Mustang", "Pinto Quarter", "Rare & Exotic", "Warmblood", "Thoroughbred", "Working Horse", "Non Horse"]
ad_for = ["Sale", "Lease"]


disciplines = ["All Around", "Barrel Racing",  "Cutting", "Dressage", "Endurance", "Eventing",
  "Hunter", "Show", "Polo", "Racing", "Reining", "Roping", "Trail", "Training", "Pleasure", "Youth", "Other"]
colors = ["Bay", "Bay Overo", "Bay Roan", "Black", "Black Overo","Blue Grulla", "Blue Roan", "Brindle", "Brown", "Bucksin", "Bucksin Overo", "Champagne", "Chesnut", "Chestnut Overo", "Chocolate",
  "Cremello", "Dun", "Dun With Black Point", "Dunalino", "Dunskin", "Grey", "Grulla", "Liver Chestnut", "Overo", "Palomino", "Perlino", "Piebalo", "Pinto", "Red Dun", "Red Roan", "Roan", "Sabino", 
  "Silver Dapple", "Smokey Black", "Sorrel", "Sorrel Overo", "Tobiano", "Tovero", "White", "Other"]
temperaments = ["Boomproof", "Extremly Calm", "Calm", "Mild Mannered", "Average", "Energetic", "Spirited", "Extremly Spirited", "Hot", "Professionals Only"]
experiences =  ["Prospect", "Trained", "Competed & Shown", "Champion"]
ai_types = ["Cooled", "Frozen", "Both"]

birth = "2004-03-01"


horse.packages.create([
	{name: "Basic", price: 0, duration: 3, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 9.95, duration: 3, max_photo_upload: 15, max_video_upload: 0},
	{name: "Deluxe", price: 18.95, duration: 3, max_photo_upload: 15, max_video_upload: 2},
	{name: "Exclusive", price: 29.95, duration: 3, max_photo_upload: 15, max_video_upload: 4}
	])

stud.packages.create([
	{name: "Basic", price: 0, duration: 3, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 9.95, duration: 3, max_photo_upload: 15, max_video_upload: 0},
	{name: "Deluxe", price: 18.95, duration: 3, max_photo_upload: 15, max_video_upload: 2},
	{name: "Exclusive", price: 49.95, duration: 6, max_photo_upload: 15, max_video_upload: 4}
	])

tack.packages.create([
	{name: "Basic", price: 0, duration: 3, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 2.95, duration: 3, max_photo_upload: 5, max_video_upload: 0}
	])

trailer.packages.create([
	{name: "Basic", price: 0, duration: 3, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 9.95, duration: 3, max_photo_upload: 15, max_video_upload: 0}
	])

real_estate.packages.create([
	{name: "Basic", price: 0, duration: 3, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 19.95, duration: 3, max_photo_upload: 12, max_video_upload: 0},
	{name: "Deluxe", price: 29.95, duration: 3, max_photo_upload: 20, max_video_upload: 2}
	])

my_service.packages.create([
	{name: "Basic", price: 0, duration: 12, max_photo_upload: 0, max_video_upload: 0},
	{name: "Premium", price: 14.95, duration: 12, max_photo_upload: 10, max_video_upload: 2}
	])



genders.each do |gender|
  GenderOption.create(name: gender)
end

breeds.each do |breed|
  BreedOption.create(name: breed)
end

colors.each do |color|
  ColorOption.create(name: color)
end

temperaments.each do |temperament|
  TemperamentOption.create(name: temperament)
end 

experiences.each do |experience|
  ExperienceOption.create(name: experience)
end  

disciplines.each do |discipline|
  DisciplineOption.create(name: discipline)
end

ai_types.each do |ai|
  AiTypeOption.create(name: ai)
end


def random_dec (min, max)
  rand * (max-min) + min
end


horse_images = []
(1..4).each do |num|
  horse_images << File.open(Rails.application.config.assets.paths[0]+"/horse"+num.to_s+".jpg")
end

trailer_images = []
(1..4).each do |num|
  trailer_images << File.open(Rails.application.config.assets.paths[0]+"/trailer"+num.to_s+".jpg")
end

packages_id_for_horse = [1, 2, 3, 4]
packages_id_for_stud = [5, 6, 7, 8]
packages_id_for_trailer = [11, 12]
ad_status = ["published", "draft"]
month_durations = [0, 1, 3, 4, 5, 6]
days_duration = [0, 7, 30]


=begin
[User, Discipline].each(&:delete_all)

User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')

Discipline.connection.execute('ALTER SEQUENCE disciplines_id_seq RESTART WITH 1')

(1..10).each do |num|
  user = User.create(
  { username: Faker::Internet.user_name,
    email: Faker::Internet.safe_email,
    password: "samasemua",
    password_confirmation: "samasemua"
  })

  user.profile.update(
    name: Faker::Name.name,
    farm_name: Faker::Company.name,
    phone_number: Faker::PhoneNumber.cell_phone,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    website: Faker::Internet.domain_name,
    about: Faker::Lorem.paragraphs(3, true).join(",")
    )
end


Picture.delete_all
Picture.connection.execute('ALTER SEQUENCE pictures_id_seq RESTART WITH 1')

Horse.delete_all
Horse.connection.execute('ALTER SEQUENCE horses_id_seq RESTART WITH 1')

(1..200).each do |num|
  horse = Horse.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      name: Faker::Name.name, gender: genders.sample,
      breed: breeds.sample, city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      ad_for: ad_for.sample, price: random_dec(5, 200).round(2),
      private_treaty: false, birth: birth,
      color: colors.sample, height: random_dec(5, 200).round(2), weight: random_dec(5, 200).round(2),
      package_id: packages_id_for_horse.sample,
      user_id: User.all.pluck(:id).sample,
      status: ad_status.sample, temperament: temperaments.sample,
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month
    })


  horse.user_name = horse.user.profile_name 
  horse.farm_name = horse.user.profile_farm_name
  horse.website = horse.user.profile_website
  horse.email = horse.user.email
  horse.phone_number = horse.user.profile_phone_number

  horse.disciplines.create(name: disciplines.sample, experience: experiences.sample)

  horse_images.each do |img|
    horse.pictures.create(name: img)
  end

  horse.banner = horse.pictures.sample.id
  horse.save!
  
end

Stud.delete_all
Stud.connection.execute('ALTER SEQUENCE studs_id_seq RESTART WITH 1')
(1..200).each do |num|
  stud = Stud.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      name: Faker::Name.name, gender: "Stallions", ai_type: ai_types.sample,
      breed: breeds.sample, city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      price: random_dec(5, 200).round(2),
      private_treaty: false, birth: birth,
      color: colors.sample, height: random_dec(5, 200).round(2), weight: random_dec(5, 200).round(2),
      package_id: packages_id_for_stud.sample,
      user_id: User.all.pluck(:id).sample,
      status: ad_status.sample, temperament: temperaments.sample,
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month
    })


  stud.user_name = stud.user.profile_name 
  stud.farm_name = stud.user.profile_farm_name
  stud.website = stud.user.profile_website
  stud.email = stud.user.email
  stud.phone_number = stud.user.profile_phone_number

  stud.disciplines.create(name: disciplines.sample, experience: experiences.sample)

  horse_images.each do |img|
    stud.pictures.create(name: img)
  end

  stud.banner = stud.pictures.sample.id
  stud.save!
  
end

=end

models = ["Classic", "Stratus Express", "Ranchhand", "Baron" ,"Renegade"]
materials = ["Fiberglass", "Aluminum", "ombination"]
hitchs = ["Bumper Pull", "Gooseneck"]
brands = ["Charmac", "Trails West", "Bison", "Other", "Merhow", "Silver Star"]

Trailer.delete_all
Trailer.connection.execute('ALTER SEQUENCE trailers_id_seq RESTART WITH 1')
(1..200).each do |num|
  trailer = Trailer.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      price: random_dec(5, 200).round(2),
      private_treaty: false,
      color: "white",  
      brand: brands.sample, model: models.sample, year: [2001..2014].sample.to_s,
      material: materials.sample, hitch: hitchs.sample, axles: [1..3].sample.to_s, hauls: [1..6].sample.to_s,
      package_id: packages_id_for_trailer.sample,
      user_id: User.all.pluck(:id).sample,
      status: "published",
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month
    })


  trailer.user_name = trailer.user.profile_name 
  trailer.farm_name = trailer.user.profile_farm_name
  trailer.website = trailer.user.profile_website
  trailer.email = trailer.user.email
  trailer.phone_number = trailer.user.profile_phone_number

  trailer_images.each do |img|
    trailer.pictures.create(name: img)
  end

  trailer.banner = trailer.pictures.sample.id
  trailer.save!
  
end


