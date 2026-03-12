class Task < ApplicationRecord
  validates :title, presence: true

  scope :newest_first, -> { order(created_at: :desc) }

  def toggle_completion!
    update!(completed: !completed)
  end
end
