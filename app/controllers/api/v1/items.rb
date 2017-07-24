module API
  module V1
    class Items < Grape::API
      include API::V1::Defaults

      resources :todos do
        params do
          requires :todo_id, type: Integer
        end

        route_param :todo_id do
          resources :items do
            get '', root: :items do
              @todo = Todo.find(permitted_params[:todo_id])
              @todo.items
            end
          end
        end
      end
    end
  end
end
