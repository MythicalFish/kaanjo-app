module SharedMethods
  extend ActiveSupport::Concern
  included do


    after_find :setup_totals

    attr_accessor :reaction_total, :impression_total, :ctr, 
      :type_total_1, :type_total_2, :type_total_3, :type_total_4, :type_total_5

    @@opts = { from: Date.today, to: Date.today }

    def self.with_totals opts = {}

      @@opts = @@opts.merge(opts)

      collection = []

      all.each do |w|
        collection << w
      end

      collection = collection.sort_by &@@opts[:order_by]
      collection.reverse! if @@opts[:direction] == 'DESC'
      collection
      
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
        args[:reaction_type] = opts[:type] if opts[:type]
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
        "/////#{model_name.collection}-#{id}" <<
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
      get_total_for reactions, opts
    end

    def get_impression_total opts = {}
      get_total_for impressions, opts
    end

    def get_ctr opts = {}
      ctr = ((get_reaction_total(opts).to_f / get_impression_total(opts).to_f) * 100).round(2)
      ctr = 0 unless ctr > 0
      ctr
    end

    private

    def setup_totals

      #@reaction_total = self.get_reaction_total(@@opts)
      instance_variable_set("@reaction_total",self.get_reaction_total(@@opts))
      @impression_total = self.get_impression_total(@@opts)
      @ctr = self.get_ctr(@@opts)

      ReactionType.all.each do |t|
        instance_variable_set(
          "@type_total_#{t.id}",
          self.get_reaction_total({type:t}.merge(@@opts))
        )
      end

    end

    def assign_sid
      return if self.sid
      begin
        secure_id = SecureRandom.hex(12)
      end while Product.where(:sid => secure_id).exists?
      self.sid = secure_id
    end

  end
end
