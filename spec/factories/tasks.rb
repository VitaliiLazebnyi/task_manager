FactoryBot.define do
  factory :task do
    title    { 'Task ' + Time.now.to_i.to_s }
    priority { 1 }
    done     { true }
    deadline { Date.today }
  end

  factory :invalid_task, class: Task do
    title    { '' }
    priority { 0 }
    done     { true }
    deadline { Date.today - 1 }
  end
end
