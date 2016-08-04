module ReactionQueries
  extend ActiveSupport::Concern
  included do

    def self.with_counts(opts = {from:nil, to:nil, order: 'impression_count', direction:'DESC'})

      group_model = 'products'
      group_model = 'users' if self.model_name.collection == 'webmasters'

      query = "#{group_model}.*" <<
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
        joins(:reactions).
        joins(:impressions).
        group("#{group_model}.id").
        where(
          "reactions.created_at" => opts[:from]..opts[:to],
          "impressions.created_at" => opts[:from]..opts[:to]
        ).order("#{opts[:order]} #{opts[:direction]}")

    end

  end
end
