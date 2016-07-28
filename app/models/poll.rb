class Poll < ActiveRecord::Base

has_many :questions,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: :Poll

belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User

end
