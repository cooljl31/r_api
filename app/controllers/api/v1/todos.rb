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
      end
    end
  end
end
