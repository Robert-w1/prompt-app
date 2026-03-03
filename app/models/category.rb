class Category < ApplicationRecord
  has_many :chats

  validates :name, :system_prompt, presence: true
end
