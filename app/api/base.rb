module API
  class Base < Grape::API
     before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
      header['Access-Control-Allow-Headers'] = 'accept, content-type'
     end

    mount API::V1::Base
  end
end
