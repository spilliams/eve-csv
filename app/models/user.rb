class User < ActiveRecord::Base
  has_many :characters, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :api_id, :api_key, :first_name, :last_name, :default_character_id,
                  :current_character_id, :status
  
  validate :api_id_is_sane, :on => :updated
  
  def api
    api = Eve::API.new(:user_id => api_id, :api_key => api_key)
    api.set(:character_id => "#{default_character.character_id}") unless default_character_id.nil? or default_character_id.blank?
    api.set(:character_id => "#{current_character.character_id}") unless current_character_id.nil? or current_character_id.blank?
    api
  end
  
  def to_s
    if first_name and last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
  
  def current_character
    return nil if current_character_id.nil? or current_character_id.blank?
    Character.find(current_character_id)
  end
  def default_character
    return nil if default_character_id.nil? or default_character_id.blank?
    Character.find(default_character_id)
  end

private

  def api_id_is_sane
    return unless api_id.changed? or api_key.changed?
    begin
      api.account.characters
    rescue
      errors[:api_id] << "May be invalid"
      errors[:api_key] << "May be invalid"
    end
  end
  
end
