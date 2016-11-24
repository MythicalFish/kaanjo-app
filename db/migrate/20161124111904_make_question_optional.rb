class MakeQuestionOptional < ActiveRecord::Migration
  def change
    change_column :campaigns, :question, :string
    change_column :campaigns, :social_proof, :string
  end
end
