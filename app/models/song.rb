class Song < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :users, through: :playlists, source: :user
  has_many :playlists, dependent: :destroy

  validates :title, presence: true, length: 2..45
  validates_format_of :title, with: /\A[a-zA-Z\d ]*$\z/
  validates :artist, presence: true, length: 2..45
  validates_format_of :artist, with: /\A[a-zA-Z\d ]*$\z/
end
