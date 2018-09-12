FactoryBot.define do
  factory :project do
    title { 'Project ' + Time.now.to_i.to_s }
  end

  factory :invalid_project, class: Project do
    title { '' }
  end
end
