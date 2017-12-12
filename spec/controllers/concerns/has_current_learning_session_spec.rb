require 'rails_helper'

RSpec.describe HasCurrentLearningSession, type: :controller do
  controller(ActionController::Base) do
    include HasCurrentLearningSession

    def current_user
      User.new
    end
  end

  describe '#current_learning_session' do
    subject { controller.send(:current_learning_session) }

    context "when the learning session isn't stored" do
      it { is_expected.to be_nil }
    end

    context 'when the learning session is stored' do
      let(:user) { double(:user) }

      before do
        session[:learning_session] = LearningSession.new.to_h.deep_stringify_keys
      end

      it { is_expected.to be_a LearningSession }
    end
  end

end
