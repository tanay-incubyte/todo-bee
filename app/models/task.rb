class Task < ApplicationRecord
  PRIORITIES = %w[high medium low].freeze

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_blank: true

  scope :newest_first, -> { order(created_at: :desc) }
  scope :by_priority, ->(priority) { where(priority: priority) }

  def toggle_completion!
    update!(completed: !completed)
  end
end
