require 'spec_helper'

describe Task do
  it { should validate_presence_of :title }
  it { should validate_inclusion_of(:priority).in_array [1,2,3,4] }
  #it { should validate_inclusion_of(:done).in_array [true, false] }
  it { should allow_value(%w(true false)).for(:done) }

  it { is_expected.to belong_to(:project) }

  it "deadline can't be in past" do
    task = Task.new(deadline: Date.today)
    task.valid?
    expect(task.errors[:deadline]).to_not include('Should be a date in future or empty')

    task.deadline = Date.today - 1
    task.valid?
    expect(task.errors[:deadline]).to include('Should be a date in future or empty')
  end
end
