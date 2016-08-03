module ReactionQueries
  extend ActiveSupport::Concern
  included do

    def reaction_sorting
      args = {
        from: from_date,
        to: to_date
      }

      args[:order] = params[:a] if params[:a]
      args[:direction] = params[:d] if params[:d]
      args[:direction] = 'ASC' if args[:direction] == 'up'
      args[:direction] = 'DESC' if args[:direction] == 'down'
      args
    end

  end
end
