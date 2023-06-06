class CreateBeanUtilsIdCardVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :bean_utils_id_card_verifications do |t|
      t.belongs_to :application
      t.string :service_provider
      t.string :id_card_verification_code
      t.integer :state, default: 0
      t.string :access_key_encrypted
      t.string :access_secret_encrypted
      t.string :remark

      t.timestamps
    end
  end
end
