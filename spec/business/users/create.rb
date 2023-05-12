require 'rails_helper'

describe Users::Create do
  describe '#call' do
    context 'user has right attributes' do
      subject { described_class.new.call(user_attrs) }
      let(:user_attrs) { build(:user).as_json.merge(password: '123123123') }

      it 'creates a user' do
        expect do 
          subject
        end.to change(User, :count).by(1)
        expect(subject).to be_success
      end
    end

    context 'user not has attributes' do
      subject { described_class.new.call(user_attrs) }
      let(:user_attrs) { build(:user, email: '').as_json.merge(password: '123123123') }

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(0)
        expect(subject).not_to be_success
      end
    end

    context 'user has right attributes' do
      subject { described_class.new.call(user_attrs) }
      let(:user_attrs) { build(:user, email: '').as_json.merge(password: '123123123') }

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(0)
        expect(subject).not_to be_success
      end
    end
  end
end
