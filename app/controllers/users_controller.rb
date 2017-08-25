class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @playlist_user = Playlist.where(user_id: @user.id)
        @all_playlists = Playlist.all.collect(&:user)
        @all_songs = Song.joins('left join playlists on playlists.song_id = songs.id').group(:id).order('count(playlists.id) desc')
    end

    def create
        @user = User.create(user_params)

        if @user.save
            flash[:notice] = ["You have registered"]

            session[:user_id] = @user.id

            return redirect_to songs_path
        end

        errors = @user.errors.full_messages

        flash[:errors] = errors

        return redirect_to :back
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
        end
end
