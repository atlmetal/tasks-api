class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :completed, inclusion: { in: [true, false] }

  scope :pending, -> { where(completed: false) }
  scope :done,    -> { where(completed: true) }
end
