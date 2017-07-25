require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_user_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_user_obj) { described_class.new('foo','bar') }

  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_user_obj.call
        expect(token).to_not be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raise an Authentication Error' do
        expect { invalid_user_obj.call }
          .to raise_error(
          ExceptionHandler::AuthenticationError,
          /Invalid credentials/
        )
      end
    end
  end
end
