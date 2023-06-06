# frozen_string_literal: true

module BeanUtils
  module CustomErrorMessageConcern
    extend ActiveSupport::Concern

    included do
      has_many :custom_error_messages, as: :target, dependent: :destroy, class_name: "BeanUtils::CustomErrorMessage"

      def custom_error_message(key)
        custom_error_messages.detect { |record| record.key == key }&.message
      end
    end
  end
end
