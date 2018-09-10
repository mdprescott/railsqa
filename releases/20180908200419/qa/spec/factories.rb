# This will guess the Order class
FactoryBot.define do
  factory :user do
    name { "Michael" }
    email { "michael@me.com" }
  end

  factory :question do
    title { "Question Title" }
    body { "Question Body" }
  end

  factory :answer do
    body { "Answer" }
  end

  factory :comment do
    body { "Comment" }
  end

  factory :view do
  end

  factory :vote do
    upvote { true }
  end
end
