module CollectionCache

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def cache_key_collection
      count_n_max = pluck('COUNT(*)', 'MAX(updated_at)').flatten
      if count_n_max.last
        max_updated_at = Time.new(count_n_max.last).try(:utc).try(:to_s, :number)
        "#{model_name.human.pluralize.downcase}/all-#{count_n_max.first}-#{max_updated_at}"
      else
        "#{model_name.human.pluralize.downcase}/all-#{count_n_max.first}"
      end
    end
  end

end
