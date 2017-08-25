class Playlist < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :song, required: true

  has_many :songs, dependent: :destroy
end
