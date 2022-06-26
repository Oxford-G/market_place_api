class Order < ApplicationRecord
  belongs_to :user
  before_validation :set_total!
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_ids_and_quantities|
      placement = placements.build(product_id: product_ids_and_quantities[:product_id])
      yield placement if block_given?
    end
  end
end
