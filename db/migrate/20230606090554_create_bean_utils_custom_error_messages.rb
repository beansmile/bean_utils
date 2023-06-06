class CreateBeanUtilsCustomErrorMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :bean_utils_custom_error_messages do |t|
      t.text :message
      t.string :key
      t.belongs_to :target, polymorphic: true

      t.timestamps
    end
  end
end
