class Drink < ApplicationRecord
    has_many :favorites
    has_many :comments
    has_many :users, through: :favorites
end
