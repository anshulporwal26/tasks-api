class Task < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5, maximum: 105 }
end