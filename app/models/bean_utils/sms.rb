module BeanUtils
  class Sms < ApplicationRecord
    table_name = 'bean_utils_sms'

    include TencentCloudSmsConcern
    include CloudServiceSecretConcern

    service_secret_attributes "access_key", "access_secret"

    # acts_as_tenant(:application, class_name: "::Application", optional: true)
    belongs_to :application, class_name: "::Application", optional: true

    # service providers, tencent_cloud, aliyun, yunpian etc.
    # add build_#{service_provider}_client method after add new service provider
    SERVICE_PROVIDERS = ["tencent_cloud"]

    enum state: { active: 0, inactive: 1 }

    # class methods
    class << self
      def send_sms(application_id, sms_code, phone_numbers, params)
        record = find_by(application_id: application_id, sms_code: sms_code)
        record.send_sms(phone_numbers, params) if record
      end
    end

    # instance methods
    def client
      return @client if @client
      @client = public_send "build_#{service_provider}_sms_client"
      @client
    end

    def send_sms(phone_numbers, params)
      public_send "send_#{service_provider}_sms", phone_numbers, params
    end
  end
end
