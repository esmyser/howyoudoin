class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :handle
      t.text :content
      t.datetime :tweet_time
      t.string :tweet_id
      t.string :user_id
      t.string :anger
      t.float :lat, precision: 10, scale: 6
      t.float :lng, precision: 10, scale: 6

      t.timestamps null: false
    end
  end
end
