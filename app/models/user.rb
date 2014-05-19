class User < ActiveRecord::Base
	has_one :picture, as: :imageable

	TEMP_EMAIL = 'heriynt89@gmail.com'
  TEMP_EMAIL_REGEX = /heriynt89@gmail.com/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?

      # Get the existing user by email if the OAuth provider gives us a verified email
      # If the email has not been verified yet we will force the user to validate it
      #email = auth.info.email if auth.info.email && auth.info.verified_email
      user = User.where(:email => auth.info.email).first if auth.info.email

      # Create the user if it is a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: auth.info.email.blank? ? TEMP_EMAIL : auth.info.email,
          password: Devise.friendly_token[0,20],
          #remote_image_url: auth[:info][:image]
        )
        user.skip_confirmation!
        user.save!
        user_avatar = user.build_picture
        #user_avatar.remote_image_url = auth[:info][:image]
        #user_avatar.save!
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end


end
