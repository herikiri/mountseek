class Stud < ActiveRecord::Base
	include AASM

	belongs_to :package
	belongs_to :user
	has_many :pictures, as: :imageable, dependent: :destroy
	has_many :videos, as: :videoable, dependent: :destroy

	has_many :disciplines, as: :discipline, dependent: :destroy

	accepts_nested_attributes_for :disciplines

	#validates :title, :description, :city, :state, :zip_code,:breed, :birth, :user_name, :email, :stud_fee, :booking_fee, presence: true

	#validates :email, :email_format => {:message => 'is not looking good'}

	#validates :stud_fee, :booking_fee, numericality: { greater_than_or_equal_to: 0 }

	accepts_nested_attributes_for :disciplines

	is_impressionable :counter_cache => true, :column_name => :views_count, :unique => :ip_address
	acts_as_votable

	aasm column: 'status' do
    state :draft, initial: true
    state :published
    state :removed
    state :booked

    event :publish do
      transitions from: :draft, to: :published
    end

    event :make_draft do
      transitions from: :published, to: :draft
    end

    event :make_booked do
      transitions from: :published, to: :booked
    end

    event :to_booked do
      transitions from: :removed, to: :booked
    end

  end

	# Ad Stud in range of duration
	scope :published, -> { where(status: 'published') }

	scope :live, -> { where("published_end > ?", "%#{DateTime.now}%" ) }

	featured_packages = ["Deluxe", "Premium"]
	scope :featured_ad, -> { where(package_id: Package.where(name: featured_packages).map(&:id)) }
	
	scope :newest_ad, -> { order(published_at: :desc) }

	scope :favorited_by, ->(user) { where(id: user.find_liked_items.map(&:id)) }

	
	def ad_banner
		self.pictures.find(self.banner) if self.pictures.present?
	end
end
