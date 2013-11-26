require "false_friends/version"

module FalseFriends

  class User
    attr_reader :username, :name, :location, :description, :url, :posts

    # User.gather(n)
    # returns an array of n user objects
    def self.gather(n)
      users_to_create = User.list.keys.sample(n)
      users_to_create.map{ |username| User.new(username) }
    end

    # User.find_by(options)
    #
    # options <hash>
    # id: n <int>
    #   position in the users list, 1-200
    #
    # username: str <string>
    #   twitter username
    #
    # Example: User.find_by(id: 200)
    # => #<User:0x007ff0f286e2d8 ...>
    #
    # returns the requested user object

    def self.find_by(options)
      if options[:id] && options[:id].between?(1, User.list.count)
        username = User.list[options[:id]-1]
        User.new(username)
      elsif options[:username] && User.list.includes?(options[:username])
        User.new(options[:username])
      else
        raise ArgumentError, "Requested user not found in library."
      end
    end

    # User.new(username)
    #
    # username <string>
    #   twitter username
    #
    # returns user object

    def initialize(username)
      @username    = username
      @name        = User.list[username][:name]
      @location    = User.list[username][:location]
      @description = User.list[username][:description]
      @url         = User.list[username][:url]
      @posts       = User.list[username][:posts]
    end

    # avatar_url(size)
    # returns the user's uiFaces url in the closest available size
    def avatar_url(size)
      valid_sizes = [128, 64, 48, 24]
      size = valid_sizes.min { |a,b| (size-a).abs <=> (size-b).abs }
      "https://s3.amazonaws.com/uifaces/faces/twitter/#{username}/#{size}.jpg"
    end

    private
      @user_list = File.open('false_friends/users.yml', 'r'){|f| Psych.load(f) }

      def self.list
        @user_list
      end
  end

end


