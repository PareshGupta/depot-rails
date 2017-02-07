module ProductSearchable

  extend ActiveSupport::Concern

  included do

    require 'elasticsearch/model'

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 }

    def as_indexed_json(options={})
      self.as_json({
        only: [:title, :description],
        include: {
          orders: { only: [:name, :address, :email] }
        }
      })
    end 
    
  end

end
