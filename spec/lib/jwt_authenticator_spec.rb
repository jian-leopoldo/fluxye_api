require 'rails_helper'

describe JwtAuthenticator do
  describe '#authenticate!' do
    it 'returns a user' do
      user = create(:user)
      token = JwtEncoder.encode({ user_id: user.id })

      expect(described_class.new('Authorization' => "Bearer #{token}").authenticate!).to eq(user)
    end

    it 'returns an error when token is wrong' do
      token = JwtEncoder.encode({})
      expect { described_class.new('Authorization' => "Bearer #{token}").authenticate! }.to raise_error(ExceptionHandler::InvalidToken)
    end

    it 'returns an error when token is nil' do
      expect { described_class.new.authenticate! }.to raise_error(ExceptionHandler::MissingToken)
    end
  end
end
