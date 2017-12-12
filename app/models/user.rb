class User < ApplicationRecord
  has_many :repetitions

  def auth_token
    Knock::AuthToken.new(payload: { sub: id })
  end
end
