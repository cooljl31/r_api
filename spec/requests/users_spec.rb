require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_digest: user.password)
  end


  describe 'POST /singup' do
    context 'when valid request' do
      before  do
        post '/signup', params: valid_attributes.to_json, headers: headers
      end
      it 'create a new user' do
        expect(response).to have_http_status 201
      end

      it 'returns a success message' do
        expect(json['message']).to match(/Account created successfully/)
      end
    end

    context 'when invalid rewuest' do
      before do
        post '/signup', params: {}, headers: headers
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
