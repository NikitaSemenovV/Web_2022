class Reply < ApplicationRecord
    belongs_to :vacancy
    belongs_to :summery

    scope :get_new_reply, -> () {where :watched => false}
    scope :get_by_summery, -> (s) {where :summery_id => s }
    scope :find_by_vacancy, -> (id) {where :vacancy_id => id}
end
