class SongsController < ApplicationController
    def index
        @all_songs = Song.joins('left join playlists on playlists.song_id = songs.id').group(:id).order('count(playlists.id) desc')
    end

    def show
        @song = Song.find(params[:id])
        @all_playlists = Playlist.all
        # @all_playlists = Playlist.joins('left join songs on songs.user_id = playlist.user_id').group(:id).order('count(songs.id) desc')
        @playlists = Playlist.all.collect(&:song)
        # @all_users = User.joins('left join playlists on playlists.user_id = users.id').joins('left join songs on songs.user_id = users.id').group(:id).order('count(playlists.id) desc')
        # @all_songs = Song.joins('left join playlists on playlists.song_id = songs.id').group(:id).order('count(playlists.id) desc')
    end

    def create
      @song = Song.new(idea_params)
      @user = current_user

      if @song.save
          flash[:notice] = ["Thanks for adding a song!"]

          return redirect_to songs_path
      end

      errors = @song.errors.full_messages

      flash[:errors] = errors

      return redirect_to :back
    end

    private
        def idea_params
            params.require(:song).permit(:title, :artist).merge(user: current_user)
        end
end
