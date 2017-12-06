class HomeController < ApplicationController
  def index
    redirect_to questions_path
  end
end
