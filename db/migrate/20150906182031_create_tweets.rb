class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :handle
      t.string :content
      t.datetime :tweet_time
      t.integer :tweet_id
      t.integer :user_id
      t.string :anger

      t.timestamps null: false
    end
  end
end
