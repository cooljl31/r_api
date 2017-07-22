require 'rails_helper'

RSpec.describe 'Items API' do
  before do
    @todo = create(:todo)
    @items = create_list(:item, 20, todo_id: @todo.id)
  end
  let(:todo_id) { @todo.id }
  let(:id) { @items.first.id }

  describe 'GET /todos/:todo_id/items' do
    before do
      get "/todos/#{todo_id}/items"
    end

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all todo items' do
        expect(json.size).to eq 20
      end
    end

    context 'when todo does not exists' do
      let(:todo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    before do
      get "/todos/#{todo_id}/items/#{id}"
    end

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the item' do
        expect(json['id']).to eq id
      end
    end

    context 'when todo item does not exit' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Cool Name', done: false } }

    context 'when request attributes are valid' do
      before do
        post "/todos/#{todo_id}/items", params: {}
      end

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozarella' } }

    before do
      put "/todos/#{todo_id}/items/#{id}", params: valid_attributes
    end

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end

      it 'update the item ' do
        update_item = Item.find(id)
        expect(update_item.name).to match(/Mozarella/)
      end
    end

    context 'when the item does not exists' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before do
      delete "/todos/#{todo_id}/items/#{id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status 204
    end
  end
end