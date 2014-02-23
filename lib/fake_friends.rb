begin
  require "fake_friends/version"
  require 'yaml'
rescue LoadError
end

module FakeFriends

  class FakeFriend
    attr_reader :username, :name, :location, :description, :url, :posts

    # Public: FakeFriend.all
    #
    # Returns a class instance Hash variable holding the
    #   user list defined in users.yml
    def self.all
      @friends_list
    end

    # Public: FakeFriend.gather(n)
    # Returns n FakeFriend objects
    #
    # n  - An Integer from 1 to 100.
    #
    # Examples
    #
    #   FakeFriend.gather(2)
    #   # => [#<FakeFriend:0x00..>, #<FakeFriend:0x00..>]
    #
    # Returns an array of n FakeFriend objects
    def self.gather(n)
      raise ArgumentError, "Can only gather 1 to 100 FakeFriends" unless n.between?(1, 100)
      users = FakeFriend.all.keys.sample(n)
      users.map{ |username| FakeFriend.new(username) }
    end

    # Public: FakeFriend.find_by(options)
    # Returns a FakeFriend object for a specific user in the user listing
    #
    # options - The Hash of options (default: {}):
    #           :id - Integer - User's position in the user listing, 1 to 100
    #           :username - String - User's Twitter username
    #
    # Examples
    #
    #   FakeFriend.find_by(id: 101)
    #   # => #<FakeFriend:0x007ff0f286e2d8 ...>
    #
    # Returns the requested FakeFriend object if found, else raises ArgumentError
    def self.find_by(options)
      if options[:id] && options[:id].between?(1, FakeFriend.all.count)
        username = FakeFriend.all.keys[options[:id]-1]
        FakeFriend.new(username)
      elsif options[:username] && FakeFriend.all.keys.include?(options[:username])
        FakeFriend.new(options[:username])
      else
        raise ArgumentError, "Requested user not found in library."
      end
    end

    # Public: FakeFriend.new(username)
    # Creates a FakeFriend object with attributes fetched from
    # the user listing defined in users.yml and accesses via FakeFriend.all
    #
    # username  - String - a Twitter username found in the user listing
    #
    # Examples
    #
    #   FakeFriend.new('idiot')
    #   # => #<FakeFriend:0x00000101348a80 @username="idiot"...>
    #
    # Returns a FakeFriend object with attributes populated from FakeFriend.all
    def initialize(username)
      @username    = username
      @name        = FakeFriend.all[username][:name]
      @location    = FakeFriend.all[username][:location]
      @description = FakeFriend.all[username][:description]
      @url         = FakeFriend.all[username][:url]
      @posts       = FakeFriend.all[username][:posts]
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

    def self.populate_friends_list
      project_lib   = File.expand_path(File.dirname(__FILE__))
      library_file  = "#{project_lib}/fake_friends/users.yml"
      File.open(library_file, 'r'){|f| YAML.load(f) }
    end

    @friends_list = populate_friends_list
  end

end


