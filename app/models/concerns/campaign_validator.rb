module CampaignValidator
  extend ActiveSupport::Concern
  included do
    validates :name, length: {minimum: 3, maximum: 24}
  end
end