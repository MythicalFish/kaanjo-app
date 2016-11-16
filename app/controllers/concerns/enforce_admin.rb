module EnforceAdmin
  extend ActiveSupport::Concern
  included do

    before_action :enforce_admin

    private

    def enforce_admin
      unless current_user && current_user.admin?
        head(403)
      end
    end

  end
end