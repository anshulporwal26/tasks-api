class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 5, maximum: 105 }
end