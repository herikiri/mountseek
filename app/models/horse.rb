class Horse < ActiveRecord::Base
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable, dependent: :destroy
	has_many :videos, as: :videoable, dependent: :destroy
	has_one :ad, as: :adable, dependent: :destroy

	is_impressionable

	# Ad Horse where -> package type delux(id: 3) or exclusive(id: 4) 
	scope :featured_ad, -> { where(id: Ad.where(adable_type: "Horse", package_id: [3,4]).pluck(:adable_id)) }
	
	scope :newest_ad, -> { where(id: Ad.where(adable_type: "Horse").order(updated_at: :desc).pluck(:adable_id))}

	scope :published, -> { where(id: Ad.where(adable_type: "Horse", status: "published").pluck(:adable_id)) }
	
	def ad_banner
		self.pictures.find(self.ad.picture_id)
	end


	# TODO -> add validation
	#validates :title, :description, :city, :state, :breed, :gender, presence: true

end
