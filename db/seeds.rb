# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DATA_COUNT = 200;

items = [Type, Package, DisciplineOption, GenderOption, BreedOption, ColorOption, 
  TemperamentOption, ExperienceOption, AiTypeOption, TackOption, 
  TackTypeOption, ConditionOption, ServiceTypeOption, StateOption,
  HouseTypeOption]

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

TackOption.connection.execute('ALTER SEQUENCE tack_options_id_seq RESTART WITH 1')
TackTypeOption.connection.execute('ALTER SEQUENCE tack_type_options_id_seq RESTART WITH 1')
ConditionOption.connection.execute('ALTER SEQUENCE condition_options_id_seq RESTART WITH 1')
ServiceTypeOption.connection.execute('ALTER SEQUENCE service_type_options_id_seq RESTART WITH 1')
StateOption.connection.execute('ALTER SEQUENCE state_options_id_seq RESTART WITH 1')
HouseTypeOption.connection.execute('ALTER SEQUENCE house_type_options_id_seq RESTART WITH 1')

horse = Type.create(name: "Horse")
stud = Type.create(name: "Stud")
tack = Type.create(name: "Tack")
trailer = Type.create(name: "Trailer")
real_estate = Type.create(name: "Real Estate")
my_service = Type.create(name: "Service")



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

genders =["Males", "Females", "Fillies", "Geldings", "Ridglings", "Stallions", "Uboarn", "Foals", "Broodmares","Weanlings", "Yearlings", "Unknown" ] 
breeds = ["Arabian", "Big Hair", "Colors & Spots", "Drafts Gaited", "Baroque", "Mustang", "Pinto", "Quarter Horse", "Rare & Exotic", "Warmblood", "Thoroughbred", "Working Horse", "Non Horse"]
ad_for = ["Sale", "Lease"]


disciplines = ["All Around", "Barrel Racing",  "Cutting", "Dressage", "Endurance", "Eventing",
  "Hunter", "Show", "Polo", "Racing", "Reining", "Roping", "Trail", "Training", "Pleasure", "Youth", "Other"]
colors = ["Bay", "Bay Overo", "Bay Roan", "Black", "Black Overo","Blue Grulla", "Blue Roan", "Brindle", "Brown", "Bucksin", "Bucksin Overo", "Champagne", "Chesnut", "Chestnut Overo", "Chocolate",
  "Cremello", "Dun", "Dun With Black Point", "Dunalino", "Dunskin", "Grey", "Grulla", "Liver Chestnut", "Overo", "Palomino", "Perlino", "Piebalo", "Pinto", "Red Dun", "Red Roan", "Roan", "Sabino", 
  "Silver Dapple", "Smokey Black", "Sorrel", "Sorrel Overo", "Tobiano", "Tovero", "White", "Other"]
temperaments = ["Boomproof", "Extremly Calm", "Calm", "Mild Mannered", "Average", "Energetic", "Spirited", "Extremly Spirited", "Hot", "Professionals Only"]
experiences =  ["Prospect", "Trained", "Competed & Shown", "Champion"]
ai_types = ["Cooled", "Frozen", "Both"]
tacks = ["Apparel", "Accessories", 
  "Barn Supplies", "Bits", "Breast Collars", "Bridles", "Browbands & Nosebands", 
  "Chaps", "Cinches", "Girths", "Grooming", "Headstalls", "Headstalls",
  "Helmets", "Horse Boots", "Horse Blankets", "Miniature", "Reins", "Saddle Bags",
  "Saddle Pads", "Saddle Racks", "Show Apparel", "Show Tack", "Spurs", "Stirrups", "Other"]
tack_types = ["Australian", "English", "Western"]
conditions = ["New", "Excellent", "Used"]
service_types = ["Trainer", "Boarding Facility", "Farrier", 
  "Veterinarian", "Chiropractor", "Hauling", "Photographer", "Feed store", "Tack Store"]
house_types = ["Acreage With Home", "Horse Property", "Orchard", "Pasture Land", "Raw Land", "Recreational Land", "Vineyard"]

birth = "2004-03-01"

packages_id_for_horse = [1, 2, 3, 4]
packages_id_for_stud = [5, 6, 7, 8]
packages_id_for_trailer = [11, 12]

packages_id_for_tack = [9, 10]
packages_id_for_real_estate = [13, 14, 15]
packages_id_for_service = [16, 17]

ad_status = ["published", "draft"]
month_durations = [0, 1, 3, 4, 5, 6]


house_styles = ["Contemporary", "Victorian", "Cape Cod", "Ranch"]
days_duration = [0, 7, 30]

horse_images = []
trailer_images = []
real_estate_images = []
tack_images = []
service_images = []
(1..4).each do |num|
  horse_images << File.open(Rails.application.config.assets.paths[0]+"/horse"+num.to_s+".jpg")
  trailer_images << File.open(Rails.application.config.assets.paths[0]+"/trailer"+num.to_s+".jpg")
  real_estate_images << File.open(Rails.application.config.assets.paths[0]+"/real_estate"+num.to_s+".jpg")
  tack_images << File.open(Rails.application.config.assets.paths[0]+"/tack"+num.to_s+".jpg")
  service_images << File.open(Rails.application.config.assets.paths[0]+"/service"+num.to_s+".jpg")
end


genders.each do |gender|
  GenderOption.create(name: gender, checked: false)
end

breeds.each do |breed|
  BreedOption.create(name: breed, checked: false)
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

tacks.each do |tack|
  TackOption.create(name: tack)
end

tack_types.each do |tack_type|
  TackTypeOption.create(name: tack_type)
end

conditions.each do |condition|
  ConditionOption.create(name: condition)
end

service_types.each do |service_type|
  ServiceTypeOption.create(name: service_type)
end

house_types.each do |house_type|
  HouseTypeOption.create(name: house_type, checked: false)
end


Carmen::Country.named('United States').subregions.each do |carmen_obj|
  StateOption.create(name: carmen_obj.name, checked: false)
end


def random_dec (min, max)
  rand * (max-min) + min
end



User.delete_all
User.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')

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
Discipline.delete_all
Discipline.connection.execute('ALTER SEQUENCE disciplines_id_seq RESTART WITH 1')


Horse.delete_all
Horse.connection.execute('ALTER SEQUENCE horses_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
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


  horse.user_name = horse.user.username
  horse.farm_name = horse.user.profile_farm_name
  horse.website = horse.user.profile_website
  horse.email = horse.user.email
  horse.phone_number = horse.user.profile_phone_number

  horse_discipline = horse.disciplines.new(name: disciplines.sample, experience: experiences.sample)
  horse_discipline.save!

  horse_images.each do |img|
    horse_picture = horse.pictures.new(name: img)
    horse_picture.save!
  end

  horse.banner = horse.pictures.sample.id
  horse.save!
end



Stud.delete_all
Stud.connection.execute('ALTER SEQUENCE studs_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
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


  stud.user_name = stud.user.username
  stud.farm_name = stud.user.profile_farm_name
  stud.website = stud.user.profile_website
  stud.email = stud.user.email
  stud.phone_number = stud.user.profile_phone_number

  stud_discipline = stud.disciplines.new(name: disciplines.sample, experience: experiences.sample)
  stud_discipline.save!

  horse_images.each do |img|
    stud_picture = stud.pictures.new(name: img)
    stud_picture.save!
  end

  stud.banner = stud.pictures.sample.id
  stud.save!
  
end


models = ["Classic", "Stratus Express", "Ranchhand", "Baron" ,"Renegade"]
materials = ["Fiberglass", "Aluminum", "ombination"]
hitchs = ["Bumper Pull", "Gooseneck"]
brands = ["Charmac", "Trails West", "Bison", "Other", "Merhow", "Silver Star"]
axles = ["One", "Two", "Three", "Four"]

Trailer.delete_all
Trailer.connection.execute('ALTER SEQUENCE trailers_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
  trailer = Trailer.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      price: random_dec(5, 200).round(2),
      private_treaty: false,
      color: "white",  
      brand: brands.sample, model: models.sample, year: birth,
      material: materials.sample, hitch: hitchs.sample, axles: axles.sample, hauls: (1..6).to_a.sample,
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
    trailer_picture = trailer.pictures.new(name: img)
    trailer_picture.save!
  end

  trailer.banner = trailer.pictures.sample.id
  trailer.save!
  
end


RealEstate.delete_all
RealEstate.connection.execute('ALTER SEQUENCE real_estates_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
  real_estate = RealEstate.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      price: random_dec(5, 200).round(2),
      private_treaty: false,
      package_id: packages_id_for_real_estate.sample,
      user_id: User.all.pluck(:id).sample,
      status: "published",
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month,
      house_type: house_types.sample, house_style: house_styles.sample,
      year: birth, sqft: random_dec(5, 200).round(2), bedroom: (1..6).to_a.sample, 
      floor: (1..4).to_a.sample, garage: (1..4).to_a.sample, bathroom: (1..3).to_a.sample,
      total_acres: (20..400).to_a.sample
    })


  real_estate.user_name = real_estate.user.profile_name 
  real_estate.farm_name = real_estate.user.profile_farm_name
  real_estate.website = real_estate.user.profile_website
  real_estate.email = real_estate.user.email
  real_estate.phone_number = real_estate.user.profile_phone_number

  real_estate_images.each do |img|
    real_estate_picture = real_estate.pictures.new(name: img)
    real_estate_picture.save!
  end

  real_estate.banner = real_estate.pictures.sample.id
  real_estate.save!

end



Tack.delete_all
Tack.connection.execute('ALTER SEQUENCE tacks_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
  tack = Tack.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      price: random_dec(5, 200).round(2),
      package_id: packages_id_for_tack.sample,
      user_id: User.all.pluck(:id).sample,
      status: "published",
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month,
      tack: tacks.sample, tack_type: tack_types.sample, condition: conditions.sample
    })


  tack.user_name = tack.user.profile_name 
  tack.farm_name = tack.user.profile_farm_name
  tack.website = tack.user.profile_website
  tack.email = tack.user.email
  tack.phone_number = tack.user.profile_phone_number

  tack_discipline = tack.disciplines.new(name: disciplines.sample, experience: experiences.sample)
  tack_discipline.save!

  tack_images.each do |img|
    tack_picture = tack.pictures.new(name: img)
    tack_picture.save!
  end

  tack.banner = tack.pictures.sample.id
  tack.save!
  
end


Service.delete_all
Service.connection.execute('ALTER SEQUENCE services_id_seq RESTART WITH 1')
(1..DATA_COUNT).each do |num|
  service = Service.create(
    { title: Faker::Company.catch_phrase, 
      description: Faker::Lorem.paragraphs(3, true).join(","), 
      city: Faker::Address.city,
      state: Faker::Address.state, zip_code: Faker::Address.zip_code,
      package_id: packages_id_for_service.sample,
      user_id: User.all.pluck(:id).sample,
      status: "published",
      published_at: DateTime.now - days_duration.sample.days,
      published_end: DateTime.now + month_durations.sample.month,
      company: Faker::Company.catch_phrase,
      company_description: Faker::Lorem.paragraphs(3, true).join(","),
      service_type: service_types.sample
    })


  service.user_name = service.user.profile_name 
  service.farm_name = service.user.profile_farm_name
  service.website = service.user.profile_website
  service.email = service.user.email
  service.phone_number = service.user.profile_phone_number

  service_discipline = service.disciplines.new(name: disciplines.sample, experience: experiences.sample)
  service_discipline.save!

  service_images.each do |img|
    service_picture = service.pictures.new(name: img)
    service_picture.save!
  end

  service.banner = service.pictures.sample.id
  service.save!
  
end
