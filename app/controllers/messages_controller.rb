class MessagesController < ApplicationController

  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    # TODO: Allow for multiple categories
    # cat_ids = params[:message][:chat][:category_id].compact_blank
    # unless cat_ids.empty?
    #   cat_ids = cat_ids.map { |id| id.to_i }
    #   categories = Category.where(id: cat_ids)

    #   @chat.category = categories
    #   @chat.save
    # end

    # If only one category can be selected
    unless params[:message][:chat][:category_id].empty?
      cat_id = params[:message][:chat][:category_id].to_i
      category = Category.find(cat_id)
      @chat.category = category
      @chat.save
      category_prompt = "[Categories: #{@chat.category.name}]"
    end

    if @message.save
      user_message = @message.content
      combined_message = [category_prompt, user_message].compact.join("\n\n")

      ruby_llm_chat = RubyLLM.chat
      if @chat.messages.size == 1
        response = ruby_llm_chat.with_instructions(system_prompt).ask(combined_message)
        Message.create(role: "assistant", message_type: "suggestion", content: response.content, chat: @chat)
      else
        response = ruby_llm_chat.ask(combined_message)
        Message.create(role: "assistant", message_type: "answer", content: response.content, chat: @chat)
      end

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def system_prompt
    file_path = Rails.root.join("lib", "tasks", "system_prompt.txt")
    File.read(file_path)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
