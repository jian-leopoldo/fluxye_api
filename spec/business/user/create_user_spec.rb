require 'rails_helper'

describe User::CreateUser do
  describe '#call' do
    M = Dry::Monads
    it 'creates a user' do
      result = described_class.new.call(password: 'jian199834')
      expect(result).to be_a(M::Success)
    end
  end
end
