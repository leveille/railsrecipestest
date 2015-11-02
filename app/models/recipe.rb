class Recipe < ActiveRecord::Base
  belongs_to :chef
  validates :chef_id, presence: true
  validates :name, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 50 }
end
