FactoryBot.define do
  factory :question do
    content { "What's your favorite number between 0 and 9?" }
    answer { rand(0..9) }
  end
end
