require 'rails_helper'

RSpec.describe 'Todos Api', type: :request do
  subject(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }


  describe 'GET /todos' do
    before do
      get '/todos'
    end

    it 'returns todos' do
      expect(json).to_not be_empty
    end

    it 'returns 10 todos' do
      expect(json.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /todos/:id' do
    before do
      get "/todos/#{todo_id}"
    end

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json['id']).to eq todo_id
      end

      it 'returns status code' do
        expect(response).to have_http_status 200
      end
    end

    context 'when the request is invalid' do
      before do
        post '/todos', params: { title: 'Johndoe' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Create by can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { {title: 'Sharing'} }

    context 'when the record exists' do
      before do
        put "/todos/#{todo_id}", params: valid_attributes
      end

      it 'update the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before do
      delete "/todos/#{todo_id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end
