class User < ApplicationRecord
  def auth_token
    Knock::AuthToken.new(payload: { sub: id })
  end
end
