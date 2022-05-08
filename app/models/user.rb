class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_favoritor
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one_attached :avatar
  has_many :fav_categories
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
            file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  after_create :subscribe_to_list

  def subscribe_to_list
    MailyHerald.subscribe(self, :all_users)
  end

  def to_s
    "#{self.name}"
  end
end