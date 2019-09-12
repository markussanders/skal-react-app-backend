class User < ApplicationRecord
    has_many :favorites
    has_many :comments
    has_many :drinks, through: :favorites
    has_many :searches
end
