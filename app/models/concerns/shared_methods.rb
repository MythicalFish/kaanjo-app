module SharedMethods
  extend ActiveSupport::Concern
  included do

    private

    def assign_sid
      begin
        secure_id = SecureRandom.hex(12)
      end while Product.where(:sid => secure_id).exists?
      self.sid = secure_id
    end

  end
end
