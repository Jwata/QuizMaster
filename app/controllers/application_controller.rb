class ApplicationController < ActionController::Base
  include Authenticable
  include HasCurrentLearningSession
end
