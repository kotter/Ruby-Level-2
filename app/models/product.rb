class Product < ActiveRecord::Base
  validates :title, :sku, :price, presence: true
  validates :price, numericality: true

  has_many :line_items
  has_many :carts, through: :line_items, source: :itemized, source_type: 'Cart'
  has_many :orders, through: :line_items, source: :itemized, source_type: 'Order'
  belongs_to :related_product, class_name: "Product", foreign_key: "related_product_id"

  has_attached_file :image, styles: { medium: "700x900>", thumb: "120x80>"}, default_url: "/images/:style/missing.png"

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def image_thumb
  	"http://www.thatnuttyguy.com#{image.url(:thumb)}"
  end
end
