class ChatProject < ApplicationRecord
  belongs_to :chat
  belongs_to :project
end
