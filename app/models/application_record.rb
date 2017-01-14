class ApplicationRecord < ActiveRecord::Base
  require 'json_web_token'

  self.abstract_class = true
end
