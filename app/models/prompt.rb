class Prompt < ApplicationRecord
  belongs_to :message
  belongs_to :project

  validates :name, presence: true
end
