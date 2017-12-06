module SystemMacros
  def login_user(user = nil)
    user ||= create(:user)
    visit questions_path(token: user.auth_token.token)
  end
end
