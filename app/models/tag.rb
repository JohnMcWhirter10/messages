class Tag < ApplicationRecord
  has_many :message_tags
  has_many :messages, through: :message_tags

  validates :name, presence: true, uniqueness: true
end
