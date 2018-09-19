class Task < ActiveRecord::Base
  validates :title,    presence: true
  validates :priority, inclusion: { in: [1, 2, 3, 4] }
  validates :done,     inclusion: { in: [true, false] }
  validate  :is_valid_deadline?

  belongs_to :project

  scope :by_priority, -> { order(:priority) }

  def switch_done
    update(done: !done)
  end

  def update_priority(prior)
    update(priority: prior)
  end

  private

  def is_valid_deadline?
    if deadline && deadline < Date.today
      errors.add(:deadline, 'Should be a date in future or empty')
    end
  end
end
