class AddSocialProofSentence < ActiveRecord::Migration
  def up
    add_column :campaigns, :social_proof, :string, null: false
    change_column :campaigns, :question, :string, null: false
    change_column :campaigns, :name, :string, null: false
  end
  def down
    remove_column :campaigns, :social_proof
  end
end
