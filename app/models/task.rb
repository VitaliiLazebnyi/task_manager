class Task < ActiveRecord::Base
  validates :title,    presence: true
  validates :priority, inclusion: { in: [1, 2, 3, 4] }
  validates :done,     inclusion: { in: [true, false] }
  validate  :is_valid_deadline?

  belongs_to :project

  private
  def is_valid_deadline?
    if deadline && deadline < Date.today
      errors.add(:deadline, 'Should be a date in future.')
    end
  end
end
