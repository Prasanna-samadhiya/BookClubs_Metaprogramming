class Bookclub < ApplicationRecord
  has_and_belongs_to_many :users

  include Joinable
  joinable_with :users
end
