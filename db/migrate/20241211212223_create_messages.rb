class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
