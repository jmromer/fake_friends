begin
  require "fake_friends/version"
  require 'yaml'
rescue LoadError
end

module FakeFriends

  class FakeFriend
    attr_reader :username, :name, :location, :description, :url, :posts

    # Friend.gather(n)
    # returns an array of n user objects
    def self.gather(n)
      raise ArgumentError, "Can only gather 1 to 101 FakeFriends" unless n.between?(1, 101)
      users = FakeFriend.list.keys.sample(n)
      users.map{ |username| FakeFriend.new(username) }
    end

    # FakeFriend.find_by(options)
    #
    # options <hash>
    # id: n <int>
    #   position in the users list, 1-101
    #
    # username: str <string>
    #   twitter username
    #
    # Example: FakeFriend.find_by(id: 101)
    # => #<User:0x007ff0f286e2d8 ...>
    #
    # returns the requested user object

    def self.find_by(options)
      if options[:id] && options[:id].between?(1, FakeFriend.list.count)
        username = FakeFriend.list.keys[options[:id]-1]
        FakeFriend.new(username)
      elsif options[:username] && FakeFriend.list.keys.include?(options[:username])
        FakeFriend.new(options[:username])
      else
        raise ArgumentError, "Requested user not found in library."
      end
    end

    # FakeFriend.new(username)
    #
    # username <string>
    #   twitter username
    #
    # returns user object

    def initialize(username)
      @username    = username
      @name        = FakeFriend.list[username][:name]
      @location    = FakeFriend.list[username][:location]
      @description = FakeFriend.list[username][:description]
      @url         = FakeFriend.list[username][:url]
      @posts       = FakeFriend.list[username][:posts]
    end

    # avatar_url(size)
    # returns the user's uiFaces url in the closest available size
    def avatar_url(size)
      valid_sizes = [128, 73, 48, 24]
      size = valid_sizes.min { |a,b| (size-a).abs <=> (size-b).abs }
      "https://s3.amazonaws.com/uifaces/faces/twitter/#{username}/#{size}.jpg"
    end

    private
      mydir         = File.expand_path(File.dirname(__FILE__))
      libary_file   = mydir + '/fake_friends/users.yml'
      @friends_list = File.open(libary_file, 'r'){|f| YAML.load(f) }

      def self.list
        @friends_list
      end
  end

end


