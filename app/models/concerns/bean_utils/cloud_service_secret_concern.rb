# frozen_string_literal: true

module BeanUtils
  module CloudServiceSecretConcern
    extend ActiveSupport::Concern

    included do
      attr_accessor :access_key, :access_secret

      def access_key=(value)
        @access_key = value
        encrypt_access_key
      end

      def access_secret=(value)
        @access_secret = value
        encrypt_access_secret
      end

      def access_key_decrypted
        @access_key_decrypted ||= self.class.aes128_decrypt(access_key_encrypted)
      end

      def access_secret_decrypted
        @access_secret_decrypted ||= self.class.aes128_decrypt(access_secret_encrypted)
      end

      def encrypt_access_key
        self.access_key_encrypted = self.class.aes128_encrypt(access_key)
      end

      def encrypt_access_secret
        self.access_secret_encrypted = self.class.aes128_encrypt(access_secret)
      end
    end
  end
end
