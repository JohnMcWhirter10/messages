class Message < ApplicationRecord
  has_one_attached :video_file
  has_one_attached :thumbnail_file

  has_many :message_tags, dependent: :destroy
  has_many :tags, through: :message_tags

  validates :title, presence: true
  validates :video_file, presence: true
  validate :validate_video_file, if: -> { video_file.attached? }
  validate :validate_thumbnail_file, if: -> { thumbnail_file.attached? }

  private

  # Custom validation for video file
  def validate_video_file
    if video_file.attached?
      unless video_file.content_type.start_with?('video/')
        errors.add(:video_file, 'must be a video file')
      end
      if video_file.byte_size > 1000.megabytes
        errors.add(:video_file, 'size must be less than 1000MB')
      end
    end
  end

  # Custom validation for thumbnail file
  def validate_thumbnail_file
    if thumbnail_file.attached?
      unless thumbnail_file.content_type.start_with?('image/')
        errors.add(:thumbnail_file, 'must be an image')
      end
      if thumbnail_file.byte_size > 5.megabytes
        errors.add(:thumbnail_file, 'size must be less than 5MB')
      end
    end
  end
end
