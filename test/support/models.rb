# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :contacts, dependent: :destroy

  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end

class Contact < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
