class User < ActiveRecord::Base
  has_many :characters, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :api_id, :api_key, :first_name, :last_name
  
  validate :api_id_is_sane, :on => :update
  
  def api
    api = Eve::API.new(:user_id => api_id, :api_key => api_key)
    api.set(:character_id => "#{character.character_id}") unless character_id.nil? or character_id.blank?
    api
  end
  
  def to_s
    if first_name and last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
  
  def character
    return nil if character_id.nil? or character_id.blank?
    Character.find(character_id)
  end

private

  def api_id_is_sane
    begin
      api.account.characters
    rescue
      errors[:api_id] << "May be invalid"
      errors[:api_key] << "May be invalid"
    end
  end
  
end
