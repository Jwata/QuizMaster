class Question < ApplicationRecord
  validates :content, presence: true
  validates :answer, presence: true

  attribute :answer, AnswerType.new
  delegate :correct?, to: :answer
end
