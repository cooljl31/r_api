module API
  module V1
    class Items < Grape::API
      include API::V1::Defaults

      resources :todos do
        params do
          requires :todo_id, type: Integer
        end

        desc 'Return a Item'
        route_param :todo_id do
          resources :items do
            get '', root: :items do
              @todo = Todo.find(permitted_params[:todo_id])
              @todo.items
            end
          end
        end
      end

      resources :todos do
        desc 'Create Item'
        params do
          requires :name, type: String, desc: 'Item name'
          requires :done, type: Boolean, desc: 'Item status'
        end
        route_param :todo_id do
          resources :items do
            post '', root: :items do
              @todo = Todo.find_by(permitted_params[:todo_id])
              @todo.items.create!(permitted_params)
            end
          end
        end
      end
    end
  end
end
