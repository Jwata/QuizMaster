class AnswerType < ActiveRecord::Type::Value
  def cast(value)
    Answer.new(value)
  end

  def serialize(value)
    value.to_s
  end
end
