# frozen_string_literal: true

module BeanUtils
  class ThirdPartyApplication < ApplicationRecord
    include DataEncryptConcern

    # acts_as_tenant(:application, class_name: "::Application", optional: true)
    belongs_to :application, class_name: "::Application", optional: true
    validates_uniqueness_of :type, scope: :application_id

    class << self
      # usage: application_attrs :api_base_uri, :site, :oauth_redirect_url
      def application_attrs(*attr_names)
        attr_names.each do |attr_name|
          define_method attr_name do
            config.dig(attr_name.to_s) || config.dig(attr_name.to_sym)
          end

          define_method "#{attr_name}=" do |value|
            config[attr_name] = value
          end
        end
      end

      # usage: application_secret_attrs :client_id, :client_secret, :map_api_key
      def application_secret_attrs(*attr_names)
        attr_names.each do |attr_name|
          define_method attr_name do
            config.dig(attr_name.to_s) || config.dig(attr_name.to_sym)
          end

          define_method "#{attr_name}=" do |value|
            config[attr_name] = self.class.aes128_encrypt(value)
          end

          define_method "#{attr_name}_decryption" do
            self.class.aes128_decrypt(self.public_send(attr_name))
          end
        end
      end
    end
  end
end
