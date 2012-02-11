class User < ActiveRecord::Base
  has_many :characters
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :api_id, :api_key, :first_name, :last_name
  
  validate :api_id_is_sane
  
  def api
    Eve::API.new(:user_id => api_id, :api_key => api_key)
  end
  
  def to_s
    if first_name and last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

private

  def api_id_is_sane
    
  end
  
end
