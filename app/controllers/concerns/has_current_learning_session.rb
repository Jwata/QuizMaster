module HasCurrentLearningSession
  extend ActiveSupport::Concern

  included do
    helper_method :current_learning_session
  end

  private

    def current_learning_session
      return unless session[:learning_session]
      @_learning_session ||= LearningSession.new(session[:learning_session].deep_symbolize_keys)
    end
end
