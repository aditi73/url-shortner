class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      # You'll want to add some attributes here...
      t.string :full_url #long_url
      t.string :short_code
      t.string :title
      t.integer :click_count, default: 0
      t.timestamps
    end
  end
end
