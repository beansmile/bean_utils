module BeanUtils
  class IdCardVerification < ApplicationRecord
    include TencentCloudIdCardVerificationConcern
    include CloudServiceSecretConcern

    acts_as_tenant(:application, class_name: "::Application", optional: true)

    # service providers, tencent_cloud, aliyun, yunpian etc.
    # add build_#{service_provider}_client method after add new service provider
    SERVICE_PROVIDERS = ["tencent_cloud"]

    enum state: { active: 0, inactive: 1 }

    # class methods
    class << self
      def verify_id_card(application_id, id_card_verification_code, id_card, name)
        record = find_by(application_id: application_id, id_card_verification_code: id_card_verification_code)
        record.verify_id_card(id_card, name) if record
      end

      def ocr_verify_id_card(application_id, id_card_verification_code, id_card, name, image_base64 = nil, image_url = nil)
        record = find_by(application_id: application_id, id_card_verification_code: id_card_verification_code)
        record.ocr_verify_id_card(id_card, name, image_base64, image_url) if record
      end
    end

    # instance methods
    def client
      return @client if @client
      @client = public_send "build_#{service_provider}_id_card_verification_client"
      @client
    end

    def verify_id_card(id_card, name)
      public_send "#{service_provider}_id_card_verification", id_card, name
    end

    def ocr_verify_id_card(id_card, name, image_base64 = nil, image_url = nil)
      public_send "#{service_provider}_id_card_ocr_verification", id_card, name, image_base64, image_url
    end
  end
end
