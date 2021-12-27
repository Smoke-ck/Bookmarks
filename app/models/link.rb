class Link < ApplicationRecord
    paginates_per 6
    store :meta_data, accessors: [ :description, :image, :title  ], coder: JSON
    validates :url, presence: true
    has_one_attached :thumbnail
    belongs_to :user
end
