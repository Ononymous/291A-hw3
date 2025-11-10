class Message < ApplicationRecord
  # Associations
  belongs_to :conversation
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  
  # Validations
  validates :content, presence: true
  validates :sender_role, presence: true, inclusion: { in: %w[initiator expert] }
  
  # Callbacks
  after_create :update_conversation_last_message_at
  
  private
  
  def update_conversation_last_message_at
    conversation.update(last_message_at: created_at)
  end
end
