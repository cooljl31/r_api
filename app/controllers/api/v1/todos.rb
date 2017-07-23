module API
  module V1
    class Todos < Grape::API
      include API::V1::Defaults

      resources :todos do
        desc 'Return all todos'
        get '', root: :todos do
          Todo.all
        end

        desc 'Return a Todo'
        params do
          requires :id, type: Integer, desc: 'ID of the Todo'
        end
        get ':id', root: :todos do
          Todo.where(id: permitted_params[:id])
        end

        desc 'Create Todos'
        params do
          requires :title, type: String, desc: 'Todo title'
          requires :created_by, type: String, desc: 'Todo created by'
        end
        post '', root: :todos do
          @todo = Todo.new(permitted_params)
          if @todo.save
            return @todo
          else
            return @todo.errors
          end
        end

        desc 'Update Todo'
        params do
          requires :id, type: Integer, desc: 'Todo Id'
          optional :title, type: String, desc: 'Todo title'
          optional :created_by, type: String, desc: 'Todo updated by'
        end
        put ':id', root: :todos do
          @todo = Todo.find(permitted_params[:id])
          @todo.update(permitted_params)
          return @todo.errors
        end

        desc 'Delete Todos'
        params do
          requires :id, type: Integer, desc: 'Todo ID'
        end
        delete ':id', root: :todos do
          @todo = Todo.destroy(permitted_params[:id])
          return @todo.errors
        end
      end
    end
  end
end
