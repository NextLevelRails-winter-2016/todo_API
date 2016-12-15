FactoryGirl.define do
  factory :homework, class: Task do
    association :user
    name "complete homework"
    priority 1
    due_date { DateTime.now }
  end

  factory :email, class: Task do
    association :user
    name "Reply to Zack's Email"
    priority 2
    due_date { DateTime.now + 1.day }
  end

  factory :invalid_task, class: Task do
    name nil
    priority nil
    due_date nil
  end
end
