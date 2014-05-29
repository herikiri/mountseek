class Ad < ActiveRecord::Base
	belongs_to :user
	belongs_to :package
  has_one :picture, as: :imageable
	include AASM

	scope :is_draft, -> { where(status: 'draft') }
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
end
