class CreateBeanUtilsSms < ActiveRecord::Migration[7.0]
  def change
    create_table :bean_utils_sms do |t|
      t.belongs_to :application
      t.string :service_provider
      t.string :sms_code
      t.integer :state, default: 0
      t.string :access_key_encrypted
      t.string :access_secret_encrypted
      t.string :template_id
      t.string :region_id
      t.string :sign_name
      t.string :sdk_appid
      t.string :remark

      t.timestamps
    end
  end
end
