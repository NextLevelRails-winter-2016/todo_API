module Requests

  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module AuthHelpers
    def authentication_token(user)
      post '/v1/user_token', params: {
        auth: {
          email: user.email,
          password: user.password
        }
      }

      json['jwt']
    end
  end
end
