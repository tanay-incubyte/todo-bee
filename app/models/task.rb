class Task < ApplicationRecord
  PRIORITIES = %w[high medium low].freeze

  belongs_to :category, optional: true

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_blank: true

  scope :newest_first, -> { order(created_at: :desc) }
  scope :by_priority, ->(priority) { where(priority: priority) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :active, -> { where(completed: false) }
  scope :completed_tasks, -> { where(completed: true) }
  scope :by_due_date, -> { order(Arel.sql("CASE WHEN due_date IS NULL THEN 1 ELSE 0 END, due_date ASC")) }
  scope :by_priority_order, -> { order(Arel.sql("CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 ELSE 4 END")) }

  def toggle_completion!
    update!(completed: !completed)
  end
end
