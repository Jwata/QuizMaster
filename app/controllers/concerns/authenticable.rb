# Overriding Knock::Authenticable
module Authenticable
  extend ActiveSupport::Concern
  include Knock::Authenticable

  included do
    before_action :authenticate_user
    before_action :redirect_after_authentication
  end

  def unauthorized_entity(entity)
    render file: 'public/401.html', status: :unauthorized
  end

  private

    def token
      super || session[:token]
    end

    def redirect_after_authentication
      return unless params[:token]
      session[:token] = params[:token]
      redirect_to request.path
    end
end
