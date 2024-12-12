class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy, :show, :remove_video, :remove_thumbnail]

  # GET /
  def index
    if params[:tag]
      @messages = Message.joins(:tags).where(tags: { name: params[:tag] })
    else
      @messages = Message.all
    end
  end

  # GET /messages/:id
  def show
    # The @message instance variable is already set by the set_message before_action
  end

  # GET /messages/new
  def new
    @message = Message.new
    @all_tags = Tag.all
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @all_tags = Tag.all

    # Associate or create tags
    assign_tags

    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  # GET /messages/:id/edit
  def edit
    @message = Message.find(params[:id])
    @all_tags = Tag.all 
  end

  # PATCH/PUT /messages/:id
  def update
    if @message.update(message_params)
      # Reassign or create tags after updating the message
      assign_tags

      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /messages/:id/delete
  def destroy
    @message.thumbnail_file.purge if @message.thumbnail_file.attached?
    @message.video_file.purge if @message.video_file.attached?

    @message.tags.clear
    @message.destroy

    redirect_to root_path, notice: 'Message was successfully deleted.'
  end

  # DELETE /messages/:id/remove_video
  def remove_video
    @message.video_file.purge
    redirect_to edit_message_path(@message), notice: 'Video removed.'
  end

  # DELETE /messages/:id/remove_thumbnail
  def remove_thumbnail
    @message.thumbnail_file.purge
    redirect_to edit_message_path(@message), notice: 'Thumbnail removed.'
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :description, :content, :thumbnail_file, :video_file)
  end

  def assign_tags
    if params[:message][:tags].present?
      tag_names = params[:message][:tags].reject(&:blank?) # Remove blank tags
      tags = tag_names.map { |name| Tag.find_or_create_by(name: name) } # Find or create tags
      @message.tags = tags
    else
      @message.tags.clear
    end
  end
end
