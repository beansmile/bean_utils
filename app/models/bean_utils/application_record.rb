module BeanUtils
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    include DataEncryptConcern
  end
end
