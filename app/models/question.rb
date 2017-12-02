class Question < ApplicationRecord
  attribute :answer, :answer
  delegate :correct?, to: :answer
end
