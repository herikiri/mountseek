class Horse < ActiveRecord::Base
	include AASM
	
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable, dependent: :destroy
	has_many :videos, as: :videoable, dependent: :destroy


	# TODO -> add validation
	#validates :title, :description, :city, :state, :breed, :gender, presence: true

	is_impressionable
	acts_as_votable

  aasm column: 'status' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :make_draft do
      transitions from: :published, to: :draft
    end

  end

  scope :published, -> { where(status: "published") }

  # Ad Horse in range of duration
	scope :active, -> { where("published_end > ?", "%#{DateTime.now}%" ) }

	# Ad Horse where -> package type delux(id: 3) or exclusive(id: 4) 
	scope :featured_ad, -> { where(package_id: [3,4]) }
	
	scope :newest_ad, -> { order(published_at: :desc) }

	
	def ad_banner
		self.pictures.find(self.banner) if self.pictures.present?
	end

end
