module CampaignValidator
  extend ActiveSupport::Concern
  included do
    
    validates :name, length: {minimum: 3, maximum: 24}
    validate :number_of_scenarios

    private

    def number_of_scenarios
      errors.add(:scenarios, "Max 6 scenarios") if scenarios.size > 6
      errors.add(:scenarios, "Min 2 scenarios") if scenarios.size < 2
    end

  end
end