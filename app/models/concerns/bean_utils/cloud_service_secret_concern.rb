# frozen_string_literal: true

module BeanUtils
  module CloudServiceSecretConcern
    extend ActiveSupport::Concern

    included do
      def self.service_secret_attributes(*attr_names)
        attr_names.each do |attr_name|
          define_method("encrypt_#{attr_name}") do |value|
            self.public_send "#{attr_name}_encrypted=", self.class.aes128_decrypt(value)
          end

          define_method("#{attr_name}_decrypted") do
            self.class.aes128_decrypt(self.public_send("#{attr_name}_encrypted"))
          end

          define_method("#{attr_name}=") do |value|
            self.public_send "#{attr_name}_encrypted=", self.class.aes128_encrypt(value)
          end

          define_method("#{attr_name}") do
            self.public_send "#{attr_name}_encrypted"
          end
        end
      end
    end
  end
end
