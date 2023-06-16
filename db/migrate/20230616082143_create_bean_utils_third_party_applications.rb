class CreateBeanUtilsThirdPartyApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :bean_utils_third_party_applications do |t|
      t.string :type
      t.jsonb :config, default: {}
      t.belongs_to :application

      t.timestamps
    end
  end
end
