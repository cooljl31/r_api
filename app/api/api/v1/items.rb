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

        desc 'Create Item'
        params do
          requires :todo_id, type: String, desc: 'Item ID'
          requires :name, type: String, desc: 'Item name'
          requires :done, type: Boolean, desc: 'Item status'
        end
        route_param :todo_id do
          resources :items do
            post '', root: :items do
              @todo = Todo.find(permitted_params[:todo_id])
              @todo.items.create!(permitted_params)
            end
          end
        end

        desc 'Update Item'
        params do
          requires :todo_id, type: String, desc: 'Item ID'
          requires :id, type: String, desc: 'Item ID'
          optional :name, type: String, desc: 'Item name'
          optional :done, type: Boolean, desc: 'Item status'
        end
        route_param :todo_id do
          resources :items do
            route_param :id do
              put '', root: :items do
                @todo = Todo.find(permitted_params[:todo_id])
                @item = @todo.items.find(permitted_params[:id])
                @item.update(permitted_params)
              end
            end
          end
        end

        desc 'Delete Item'
        params do
          requires :todo_id, type: String, desc: 'Item ID'
          requires :id, type: String, desc: 'Item ID'
        end
        route_param :todo_id do
          resources :items do
            route_param :id do
              delete '', root: :items do
                @todo = Todo.find(permitted_params[:todo_id])
                @item = @todo.items.find(permitted_params[:id])
                @item.destroy
              end
            end
          end
        end
      end
    end
  end
end
