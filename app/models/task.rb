class Task < ApplicationRecord
  PRIORITIES = %w[high medium low].freeze

  belongs_to :category, optional: true

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_blank: true

  scope :newest_first, -> { order(created_at: :desc) }
  scope :by_priority, ->(priority) { where(priority: priority) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }

  def toggle_completion!
    update!(completed: !completed)
  end
end
