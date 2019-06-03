class Site < ApplicationRecord
  belongs_to :user

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true

  def set_https_status(status)
    self.https_status = status
  end
end
