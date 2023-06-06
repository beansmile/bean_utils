module BeanUtils
  class CustomErrorMessage < ApplicationRecord
    belongs_to :target, polymorphic: true, optional: true
    validates :message, :key, presence: true

    class << self
      def custom_error_message(key)
        find_by(key: key, target_id: nil)&.message
      end
    end
  end
end
