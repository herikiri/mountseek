class Horse < ActiveRecord::Base
	include AASM
	
	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable, dependent: :destroy
	has_many :videos, as: :videoable, dependent: :destroy


	validates :title, :description, :city, :state, :ad_for, :zip_code,
		:breed, :gender, :birth, :price, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0 }

	is_impressionable :counter_cache => true, :column_name => :views_count, :unique => :ip_address
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


  # Ad Horse in range of duration
	scope :published, -> { where("published_end > ?", "%#{DateTime.now}%" ) }

	# Ad Horse where -> package type delux(id: 3) or exclusive(id: 4) 
	scope :featured_ad, -> { where(package_id: [3,4]) }
	
	scope :newest_ad, -> { order(published_at: :desc) }

	scope :favorited_by, ->(user) { where(id: user.find_liked_items.map(&:id)) }

	
	def ad_banner
		self.pictures.find(self.banner) if self.pictures.present?
	end

end
