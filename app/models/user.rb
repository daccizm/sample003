class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :pictures

  def signed_in_authentication_token
  	self.authentication_token = generate_authentication_token
  end

  def signed_out_authentication_token!
  	self.authentication_token = nil
  	self.save
  end

  private

  def generate_authentication_token
  	loop do
  	  token = Devise.friendly_token
  	  break token unless User.find_by(authentication_token: token)
  	end
  end

end
