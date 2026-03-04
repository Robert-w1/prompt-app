class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  has_many :messages, dependent: :destroy

  has_many :chat_projects, dependent: :destroy
  has_many :projects, through: :chat_projects

  validates :title, presence: true
end
