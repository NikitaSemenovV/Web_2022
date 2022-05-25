class Vacancy < ApplicationRecord
  belongs_to :user

  scope :get_current_user, -> (user) { where :users => user}
end
