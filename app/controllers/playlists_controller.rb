class PlaylistsController < ApplicationController
  def create
      @song = Song.find(params[:id])

      Playlist.create(user: current_user, song: @song)

      return redirect_to songs_path
  end
end
