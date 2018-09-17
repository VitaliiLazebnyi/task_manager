class Task < ActiveRecord::Base
  validates :title,    presence: true
  validates :priority, inclusion: { in: [1, 2, 3, 4] }
  validates :done,     inclusion: { in: [true, false] }
  validate  :is_valid_deadline?

  belongs_to :project

  scope :by_priority, -> { order(:priority) }

  def update_priority(pr)
    pr = pr.to_i
    pr = 4 if pr < 1 || pr > 4

    self.update(priority: pr)
  end

  private
  def is_valid_deadline?
    if deadline && deadline < Date.today
      errors.add(:deadline, 'Should be a date in future.')
    end
  end
end
