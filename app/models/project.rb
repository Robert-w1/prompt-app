class Project < ApplicationRecord
  belongs_to :user

  has_many :chat_projects, dependent: :destroy
  has_many :chats, through: :chat_projects
  has_many :prompts, dependent: :destroy

  validates :name, presence: true
end
