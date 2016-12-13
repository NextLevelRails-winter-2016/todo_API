module Api::V1
  class ApiController < ApplicationController
    include Knock::Authenticable
  end
end
