module SharedQueries
  extend ActiveSupport::Concern
  included do

    # Deprecated

    def self.with_counts(
      opts = {
        from: Time.now.beginning_of_day, 
        to: Time.now.end_of_day, 
        order: 'impression_total', 
        direction: 'DESC'
      })

      if self.model_name.collection == 'webmasters'
        table = 'users' 
        foreign_key = 'webmaster_id'
      else
        table = 'products'
        foreign_key = 'product_id'
      end

      query = "#{table}.*" <<
        ",COUNT(distinct impressions.id) AS impression_total" <<
        ",COUNT(distinct reactions.id) AS reaction_total"

      if opts[:order] == 'total_ctr'
        query <<
          ",(COUNT(distinct reactions.id) / COUNT(distinct impressions.id)) * 100 AS total_ctr"
      end

      Scenario.all.each do |type|
        query << ",COUNT(distinct case when reactions.scenario_id = #{type.id} then reactions.id end) AS type_total_#{type.id}"
      end
      
      select(query).
        joins("
          LEFT JOIN (
            SELECT * FROM
            impressions
            WHERE
            impressions.created_at BETWEEN '#{opts[:from]}' AND '#{opts[:to]}'
          ) AS impressions
          ON #{table}.id = impressions.#{foreign_key}
        ").
        joins("
          LEFT JOIN (
            SELECT * FROM
            reactions
            WHERE
            reactions.created_at BETWEEN '#{opts[:from]}' AND '#{opts[:to]}'
          ) AS reactions
          ON #{table}.id = reactions.#{foreign_key}
        ").
        group("#{table}.id").
        order("#{opts[:order_by]} #{opts[:direction]}")

    end

  end
end
