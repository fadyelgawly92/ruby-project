class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :male_users, -> { where(gender: 'male') }
  scope :female_users, -> { where(gender: 'female') }        

  enum gender: { male: 0, female: 1, prefer_not_to_disclose: 3 }  

  mount_uploader :image, ImageUploader


  has_many :courses
  has_many :lectures
  
end
