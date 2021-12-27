class AddMetaDataToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :meta_data, :jsonb
  end
end
