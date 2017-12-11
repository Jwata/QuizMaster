require 'rails_helper'

RSpec.describe LearningSessionsController, type: :routing do
  describe 'routing' do

    it 'routes to #show' do
      expect(:get => '/learning_session').to route_to('learning_sessions#show')
    end

    it 'routes to #create' do
      expect(:post => '/learning_session').to route_to('learning_sessions#create')
    end

  end
end
