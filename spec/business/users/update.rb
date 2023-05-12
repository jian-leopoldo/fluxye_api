require 'rails_helper'

describe Users::Create do
  describe '#call' do
    subject { described_class.new.call(user_attrs) }
    let(:user_attrs) { build(:user).as_json.merge(password: '123123123') }

    it 'creates a user' do
      expect do 
        subject
      end.to change(User, :count).by(1)
      expect(subject).to be_success
    end
  end
end
