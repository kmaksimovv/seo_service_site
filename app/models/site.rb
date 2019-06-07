class Site < ApplicationRecord
  belongs_to :user

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
end
