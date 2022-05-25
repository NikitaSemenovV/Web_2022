class Summery < ApplicationRecord
  belongs_to :user

  scope :get_by_user, -> (id) { where(:user_id => id) }
end
