require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#auth_token' do
    subject { user.auth_token }

    let(:user) { User.create }

    it { is_expected.to be_a Knock::AuthToken }
  end
end
