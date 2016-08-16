module SharedQueries
  extend ActiveSupport::Concern
  included do

    def self.with_counts(opts = {from:nil, to:nil, order: 'impression_count', direction:'DESC'})

      if self.model_name.collection == 'webmasters'
        table = 'users' 
        foreign_key = 'webmaster_id'
      else
        table = 'products'
        foreign_key = 'product_id'
      end

      query = "#{table}.*" <<
        ",COUNT(distinct impressions.id) AS impression_count" <<
        ",COUNT(distinct reactions.id) AS reaction_total"

      if opts[:order] == 'total_ctr'
        query <<
          ",(COUNT(distinct reactions.id) / COUNT(distinct impressions.id)) * 100 AS total_ctr"
      end

      ReactionType.all.each do |type|
        query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
      end
      
      select(query).
        joins("LEFT OUTER JOIN reactions ON #{table}.id = reactions.#{foreign_key}").
        joins("LEFT OUTER JOIN impressions ON #{table}.id = impressions.#{foreign_key}").
        where(
          "(reactions.created_at BETWEEN '#{opts[:from]}' AND '#{opts[:to]}')" <<
          " AND (impressions.created_at BETWEEN '#{opts[:from]}' AND '#{opts[:to]}')"
        ).
        group("#{table}.id").
        order("#{opts[:order]} #{opts[:direction]}")

    end

  end
end
