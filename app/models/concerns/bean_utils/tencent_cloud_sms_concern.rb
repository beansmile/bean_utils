# frozen_string_literal: true
require 'tencentcloud-sdk-common'
require 'tencentcloud-sdk-sms'

module BeanUtils
  module TencentCloudSmsConcern
    extend ActiveSupport::Concern

    include TencentCloud::Common
    include TencentCloud::Sms::V20210111

    included do
      @@tencent_cloud_api_logger = ::Logger.new("./log/tencent_cloud_api.log")

      def build_tencent_cloud_sms_client
        cred = Credential.new(access_key_decrypted, access_secret_decrypted)
        Client.new(cred, region_id)
      end

      # 通过腾讯云发送短信
      # @param phone_numbers [String] 手机号，例如 ["13800138000"]
      # 例如：["+8613711112222"]， 其中前面有一个+号 ，86为国家码，13711112222为手机号。
      # 注：发送国内短信格式还支持0086、86或无任何国家或地区码的11位手机号码，前缀默认为+86。
      # @param params [Array] 短信模板参数，例如发验证码，传 ["123456"] 即可
      # e.g. TencentCloudAPI::Sms.send_sms(["13800138000"], "xxx", "xxx", ["123456"])
      def send_tencent_cloud_sms(phone_numbers, params)
        request = SendSmsRequest.new(
          phone_numbers,
          sdk_appid,
          template_id,
          sign_name,
          params,
        )
        client.SendSms(request)
      rescue TencentCloudSDKException => e
        @@tencent_cloud_api_logger.debug("[TencentCloudAPI] send_message_error: #{e.message}")
      end
    end
  end
end
