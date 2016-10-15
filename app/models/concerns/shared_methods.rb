module SharedMethods
  extend ActiveSupport::Concern
  included do

    def assign_sid
      return if self.sid
      begin
        secure_id = SecureRandom.hex(12)
      end while Object.const_get(self.model_name.human).where(:sid => secure_id).exists?
      self.sid = secure_id
    end

  end
end