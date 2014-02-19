begin
  require "fake_friends/version"
  require 'yaml'
rescue LoadError
end

module FakeFriends

  class FakeFriend
    attr_reader :username, :name, :location, :description, :url, :posts

    # Public: FakeFriend.gather(n)
    # Returns n FakeFriend objects
    #
    # n  - An Integer from 1 to 101.
    #
    # Examples
    #
    #   FakeFriend.gather(2)
    #   # => [#<FakeFriend:0x00..>, #<FakeFriend:0x00..>]
    #
    # Returns an array of n FakeFriend objects
    def self.gather(n)
      raise ArgumentError, "Can only gather 1 to 101 FakeFriends" unless n.between?(1, 101)
      users = FakeFriend.list.keys.sample(n)
      users.map{ |username| FakeFriend.new(username) }
    end

    # Public: FakeFriend.find_by(options)
    # Returns a FakeFriend object for a specific user in the user listing
    #
    # options - The Hash of options (default: {}):
    #           :id - Integer - User's position in the user listing, 1 to 101
    #           :username - String - User's Twitter username
    #
    # Examples
    #
    #   FakeFriend.find_by(id: 101)
    #   # => #<FakeFriend:0x007ff0f286e2d8 ...>
    #
    # Returns the requested FakeFriend object if found, else raises ArgumentError
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

    # Public: FakeFriend.new(username)
    # Creates a FakeFriend object with attributes fetched from
    # the user listing defined in users.yml and accesses via FakeFriend.list
    #
    # username  - String - a Twitter username found in the user listing
    #
    # Examples
    #
    #   FakeFriend.new('idiot')
    #   # => #<FakeFriend:0x00000101348a80 @username="idiot"...>
    #
    # Returns a FakeFriend object with attributes populated from FakeFriend.list
    def initialize(username)
      @username    = username
      @name        = FakeFriend.list[username][:name]
      @location    = FakeFriend.list[username][:location]
      @description = FakeFriend.list[username][:description]
      @url         = FakeFriend.list[username][:url]
      @posts       = FakeFriend.list[username][:posts]
    end

    # Public: returns a user's uiFaces url in the closest available size
    #
    # size  - Integer - the requested image size (length = width), in pixels
    #
    # Returns a string with the appropriate url.
    def avatar_url(size)
      valid_sizes = [128, 73, 48, 24]
      size = valid_sizes.min { |a,b| (size-a).abs <=> (size-b).abs }
      "https://s3.amazonaws.com/uifaces/faces/twitter/#{username}/#{size}.jpg"
    end

    private
      mydir         = File.expand_path(File.dirname(__FILE__))
      libary_file   = mydir + '/fake_friends/users.yml'
      @friends_list = File.open(libary_file, 'r'){|f| YAML.load(f) }

      # Private: FakeFriend.list
      #
      # Returns a class instance Hash variable holding the
      #   user list defined in users.yml
      def self.list
        @friends_list
      end
  end

end


