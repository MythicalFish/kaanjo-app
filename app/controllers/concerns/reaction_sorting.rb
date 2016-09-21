module ReactionSorting
  extend ActiveSupport::Concern
  included do

    def reaction_sorting

      order_by = :impression_total
      order_by = params[:a].to_sym if params[:a]

      direction = 'DESC'
      direction = 'ASC' if params[:d] == 'asc'

      args = {
        from: from_date,
        to: to_date,
        order_by: order_by,
        direction: direction
      }

      args

    end

  end
end
