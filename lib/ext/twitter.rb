module Twitter
  class SearchResult
    def user
      return @user if @user
      @user = Twitter::User.new
      @user.screen_name = from_user
      @user
    end
  end
end
