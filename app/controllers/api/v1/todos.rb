module API
  module V1
    class Todos < Grape::API
      include ExceptionHandler

      resources :todos do
        desc 'returns all todos'
        get '', root: :path do
          Todo.all
        end
      end
    end
  end
end
