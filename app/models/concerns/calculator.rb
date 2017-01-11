module Calculator
  extend ActiveSupport::Concern
  included do

    after_find :setup_totals

    attr_accessor :reaction_total, :impression_total, :ctr, 
      :type_total_1, :type_total_2, :type_total_3, :type_total_4, :type_total_5,
      :type_ctr_1, :type_ctr_2, :type_ctr_3, :type_ctr_4, :type_ctr_5

    @@opts = { from: Date.new(2016,11), to: Date.today }

    def with_totals opts = {}
      @@opts = @@opts.merge(opts)
      Object.const_get(self.model_name.name).find(id)
    end

    def self.with_totals opts = {}

      @@opts = @@opts.merge(opts)

      collection = []

      all.each do |o|
        collection << o
      end

      collection = collection.sort_by(&@@opts[:order_by])
      collection.reverse! if @@opts[:direction] == 'DESC'
      collection
      
    end

    def self.by_date opts = {}

      opts = {from:Date.today,to:Date.today}.merge(opts)

      results = {}

      (opts[:from]..opts[:to]).to_a.each do |date|
        
        d = date.to_s

        results[d] = {
          impression_total: 0,
          reaction_total: 0,
          ctr: 0
        }

        all.each do |o|
          o.setup_totals(from:date,to:date)
          results[d][:impression_total] += o.impression_total
          results[d][:reaction_total] += o.reaction_total
          results[d][:ctr] += o.ctr
        end

      end

      results

    end

    def get_count_for association, opts = {}

      opts = { type: false, day: Date.today }.merge(opts)

      type = opts[:type] ? opts[:type].id : 'all'
      association_name = association.model_name.collection

      key = "" <<
        "/#{model_name.collection}-#{id}" <<
        "/#{association_name}_total" <<
        "/type-#{type}" <<
        "/#{opts[:day].to_s}"

      cache_opts = {}

      if opts[:day] == Date.today
        cache_opts[:expires_in] = 10.minutes
      end

      Rails.cache.fetch(key,cache_opts) do
        from = opts[:day].beginning_of_day
        to = opts[:day].end_of_day
        args = { created_at: from..to }
        args[:scenario] = opts[:type] if opts[:type]
        association.where(args).length
      end

    end

    def get_total_for association, opts = {}

      opts = { type: false, from: Date.today, to: Date.today }.merge(opts)

      if opts[:to] == Date.today && opts[:from] != Date.today
        opts[:to] = Date.yesterday
        today = get_count_for(association, { type: opts[:type], day: Date.today })
        rest = get_total_for(association,opts)
        return today + rest
      end

      type = opts[:type] ? opts[:type].id : 'all'
      association_name = association.model_name.collection
      
      key = "" <<
        "/#{model_name.collection}-#{id}" <<
        "/#{association_name}_total" <<
        "/type-#{type}" <<
        "/from-#{opts[:from].to_s}_to-#{opts[:to].to_s}" 

      Rails.cache.fetch(key) do
        c = 0
        (opts[:from]..opts[:to]).each do |day|
          c += get_count_for(association, { type: opts[:type], day: day })
        end
        c
      end
      
    end

    def get_reaction_total opts = {}
      opts = @@opts.merge(opts)
      get_total_for reactions, opts
    end

    def get_impression_total opts = {}
      opts = @@opts.merge(opts)
      get_total_for impressions, opts
    end

    def get_ctr opts = {}
      ctr = ((get_reaction_total(opts).to_f / get_impression_total(opts).to_f) * 100).round(2)
      ctr = 0 unless ctr > 0
      ctr
    end

    def setup_totals opts = {}

      opts = @@opts.merge(opts)

      @reaction_total = self.get_reaction_total(opts)
      @impression_total = self.get_impression_total(opts)
      @ctr = self.get_ctr(opts)

      return unless self.try(:scenarios)

      self.scenarios.all.each_with_index do |t,i|
        i += 1
        instance_variable_set(
          "@type_total_#{i}",
          self.get_reaction_total({type:t}.merge(opts))
        )
        instance_variable_set(
          "@type_ctr_#{i}",
          ((instance_variable_get("@type_total_#{i}").to_f / @impression_total.to_f) * 100).round(2)
        )
      end

    end

  end
end
