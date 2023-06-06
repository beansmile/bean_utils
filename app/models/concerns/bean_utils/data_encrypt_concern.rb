# frozen_string_literal: true

module BeanUtils
  module DataEncryptConcern
    extend ActiveSupport::Concern

    included do
      def self.aes128_encrypt(data)
        return nil if data.nil?
        cipher = OpenSSL::Cipher::AES.new(128, :ECB)
        cipher.encrypt
        cipher.key = aes128_key
        Base64.strict_encode64(cipher.update(data.to_s) << cipher.final)
      end

      def self.aes128_decrypt(data)
        cipher = OpenSSL::Cipher::AES.new(128, :ECB)
        cipher.decrypt
        cipher.key = aes128_key
        cipher.update(Base64.decode64(data)) << cipher.final
      end

      def self.aes128_key
        aes_key = Rails.application.credentials.dig(Rails.env.to_sym, :aes_key)
        raise "aes_key is missing" if aes_key.blank?
        aes_key
      end
    end
  end
end
