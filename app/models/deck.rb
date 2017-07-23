class Deck < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title, presence: true
    validates :format, presence: true
    validates :description, presence: true
end
