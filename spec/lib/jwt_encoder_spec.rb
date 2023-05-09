require 'rails_helper'

describe JwtEncoder do
  describe '.encode' do
    it 'returns a JWT' do
      expect(described_class.encode({})).to be_a(String)
    end
  end
end
