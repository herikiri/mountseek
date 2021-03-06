namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    def random_dec (min, max)
      rand * (max-min) + min
    end

    genders = %w( Males Females Fillies Geldings Ridglings Stallions Uboarn Foals Broodmares Ridglings Weanlings Yearlings Folas Unknown ) 
    breeds = ["Arabian", "Big Hair", "Colors & Spots", "Drafts Gaited", "Baroque Mustang", "Pinto Quarter", "Rare & Exotic", "Warmblood", "Thoroughbred", "Working Horse", "Non Horse"]
    ad_for = ["Sale", "Lease"]
 
    colors = ["Bay", "Bay Overo", "Bay Roan", "Black", "Black Overo","Blue Grulla", "Blue Roan", "Brindle", "Brown", "Bucksin", "Bucksin Overo", "Champagne", "Chesnut", "Chestnut Overo", "Chocolate",
      "Cremello", "Dun", "Dun With Black Point", "Dunalino", "Dunskin", "Grey", "Grulla", "Liver Chestnut", "Overo", "Palomino", "Perlino", "Piebalo", "Pinto", "Red Dun", "Red Roan", "Roan", "Sabino", 
      "Silver Dapple", "Smokey Black", "Sorrel", "Sorrel Overo", "Tobiano", "Tovero", "White", "Other"]
    birth = "2004-03-01"
    
  

    horse_images = []
    (1..4).each do |num|
      horse_images << File.open(Rails.application.config.assets.paths[0]+"/horse"+num.to_s+".jpg")
    end

    

    packages_id_for_horse = [1, 2, 3, 4]
    ad_status = ["published", "draft"]
    
    [User, Horse, Ad, Picture].each(&:delete_all)
    Horse.connection.execute('ALTER SEQUENCE horses_id_seq RESTART WITH 1')
    Picture.connection.execute('ALTER SEQUENCE pictures_id_seq RESTART WITH 1')
    Ad.connection.execute('ALTER SEQUENCE ads_id_seq RESTART WITH 1')
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

    (1..50).each do |num|
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
          status: ad_status.sample
        })


      horse_images.each do |img|
        horse.pictures.create(name: img)
      end

      horse.banner = horse.pictures.sample.id
      horse.save!
      
    end
    
  end

end

