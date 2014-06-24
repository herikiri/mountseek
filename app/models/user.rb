class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :horses, dependent: :destroy
  has_many :studs, dependent: :destroy
  has_many :trailers, dependent: :destroy
  has_many :real_estates, dependent: :destroy
  has_many :tacks, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :real_estates, dependent: :destroy

  acts_as_messageable
  acts_as_voter


  delegate :name, :farm_name, :phone_number, :alt_phone_number, :website,
    to: :profile, prefix: true

  after_create :build_profile

	TEMP_EMAIL = 'change@me.com'
  TEMP_EMAIL_REGEX = /change@me.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?

      # Get the existing user by email if the OAuth provider gives us a verified email
      # If the email has not been verified yet we will force the user to validate it
      email = auth.info.email
      user = User.where(:email => email).first if email

      # Create the user if it is a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name.downcase,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : TEMP_EMAIL,
          password: Devise.friendly_token[0,20],
        )
        if user.save!
          user_profile = user.create_profile
          user_avatar = user_profile.build_user_picture
          user_avatar.remote_avatar_url = auth[:info][:image]
          user_avatar.save!
        end
        
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

  def notification_email(object)
   #return the model's email here
  end

  def display_name(object)

  end

  private
    def build_profile
      self.create_profile
    end

end
