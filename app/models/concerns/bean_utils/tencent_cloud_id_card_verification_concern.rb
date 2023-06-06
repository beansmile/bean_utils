# frozen_string_literal: true
require 'tencentcloud-sdk-common'
require 'tencentcloud-sdk-faceid'

module BeanUtils
  module TencentCloudIdCardVerificationConcern
    extend ActiveSupport::Concern

    include TencentCloud::Common
    include TencentCloud::Faceid::V20180301

    included do
      @@tencent_cloud_api_logger = ::Logger.new("./log/tencent_cloud_api.log")

      def build_tencent_cloud_id_card_verification_client
        cred = Credential.new(access_key_decrypted, access_secret_decrypted)
        # 身份认证接口不需要传region
        Client.new(cred, nil)
      end

      # 腾讯云 身份信息认证
      # https://cloud.tencent.com/document/product/1007/33188
      # @param IdCard: 身份证号
      # @type IdCard: String
      # @param Name: 姓名
      # @type Name: String
      # @param Encryption: 敏感数据加密信息。对传入信息（姓名、身份证号）有加密需求的用户可使用此参数，详情请点击左侧链接。
      # @type Encryption: :class:`Tencentcloud::Faceid.v20180301.models.Encryption`
      def tencent_cloud_id_card_verification(id_card, name)
        request = IdCardVerificationRequest.new(id_card, name)

        r = client.IdCardVerification(request)
        # 业务端自己判断是否验证成功
        # 认证结果码，收费情况如下。
        # 收费结果码：
        # 0: 姓名和身份证号一致
        # -1: 姓名和身份证号不一致
        # 不收费结果码：
        # -2: 非法身份证号（长度、校验位等不正确）
        # -3: 非法姓名（长度、格式等不正确）
        # -4: 证件库服务异常
        # -5: 证件库中无此身份证记录
        # -6: 权威比对系统升级中，请稍后再试
        # -7: 认证次数超过当日限制
        return {
          result: r.Result,
          description: r.Description,
        }
      rescue TencentCloudSDKException => e
        @@tencent_cloud_api_logger.debug("[TencentCloudAPI] id_card_verification_error: #{e.message}")
        return false
      end

      # 若是要使用OCR识别身份证，可以用这个接口
      # @param IdCard: 身份证号
      # @type IdCard: String
      # @param Name: 姓名
      # @type Name: String
      # @param ImageBase64: 身份证人像面的 Base64 值
      # 支持的图片格式：PNG、JPG、JPEG，暂不支持 GIF 格式。
      # 支持的图片大小：所下载图片经Base64编码后不超过 3M。请使用标准的Base64编码方式(带=补位)，编码规范参考RFC4648。
      # @type ImageBase64: String
      # @param ImageUrl: 身份证人像面的 Url 地址
      # 支持的图片格式：PNG、JPG、JPEG，暂不支持 GIF 格式。
      # 支持的图片大小：所下载图片经 Base64 编码后不超过 3M。图片下载时间不超过 3 秒。
      # 图片存储于腾讯云的 Url 可保障更高的下载速度和稳定性，建议图片存储于腾讯云。
      # 非腾讯云存储的 Url 速度和稳定性可能受一定影响。
      # @type ImageUrl: String
      # @param Encryption: 敏感数据加密信息。对传入信息（姓名、身份证号）有加密需求的用户可使用此参数，详情请点击左侧链接。
      # @type Encryption: :class:`Tencentcloud::Faceid.v20180301.models.Encryption`
      def tencent_cloud_id_card_ocr_verification(id_card, name, image_base64, image_url)
        request = IdCardOCRVerificationRequest.new(id_card, name, image_base64, image_url)
        r = client.IdCardOCRVerification(request)
        # 业务端自己判断是否验证成功
        # 认证结果码，收费情况如下。
        # 收费结果码：
        # 0: 姓名和身份证号一致
        # -1: 姓名和身份证号不一致
        # 不收费结果码：
        # -2: 非法身份证号（长度、校验位等不正确）
        # -3: 非法姓名（长度、格式等不正确）
        # -4: 证件库服务异常
        # -5: 证件库中无此身份证记录
        # -6: 权威比对系统升级中，请稍后再试
        # -7: 认证次数超过当日限制
        return {
          result: r.Result,
          description: r.Description,
        }
      rescue TencentCloudSDKException => e
        @@tencent_cloud_api_logger.debug("[TencentCloudAPI] id_card_verification_error: #{e.message}")
        return false
      end
    end
  end
end
