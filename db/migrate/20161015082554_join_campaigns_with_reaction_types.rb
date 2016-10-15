class JoinCampaignsWithReactionTypes < ActiveRecord::Migration
  def change
    create_join_table :campaigns, :reaction_types do |t|
      t.index :campaign_id
      t.index :reaction_type_id
    end
  end
end
