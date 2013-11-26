require 'twitter'
require 'psych'

puts 'Enter your Twitter API credentials (get some @ dev.twitter.com).'
print 'consumer key: '
twitter_cons_key = gets.chomp
print 'consumer secret: '
twitter_cons_sec = gets.chomp
print 'oauth token: '
twitter_auth_tok = gets.chomp
print 'oauth token secret: '
twitter_auth_sec = gets.chomp

Twitter.configure do |config|
  config.consumer_key        = twitter_cons_key
  config.consumer_secret     = twitter_cons_sec
  config.oauth_token         = twitter_auth_tok
  config.oauth_token_secret  = twitter_auth_sec
end

# returns array of non-retweets with time and text
def posts(twitter_username, count)
  options = { count: count, exclude_replies: true }

  Twitter.user_timeline(twitter_username, options)
         .delete_if{ |t| t.retweeted || (t.text =~ /^RT\s@/) } # remove retweets
         .map do |tweet|
          { time: tweet.created_at, text: tweet.text }
          end
end


number_of_users_to_pull = 30
number_of_posts_to_pull = 30

usernames = 'usernames.yml'
users     = File.open(usernames, 'r'){|file| Psych.load(file, usernames) }
users     = users.sample(number_of_users_to_pull)
friends   = {}

users.each_with_index do |u, i|
  ## Ensure user exists and tweets are public
  if Twitter.user?(u)
    unless Twitter.user(u).protected?

      # load user
      user = Twitter.user(u)

      # pull 100 posts
      posts = posts(u, number_of_posts_to_pull)

      # get urls if they exist
      begin
        expanded_url = user.attrs[:entities][:url][:urls].first[:expanded_url]
      rescue
        expanded_url = nil
      end

      begin
        display_url = user.attrs[:entities][:url][:urls].first[:display_url]
      rescue
        display_url = nil
      end

      # populate friends hash
      friends[u] = {
        name: user.name,
        location: user.location,
        description: user.description,
        url: { expanded: expanded_url, display: display_url },
        image: user.profile_image_url,
        posts: posts
      }
    end
  end

  # write to file as yaml
  users_lib = 'users.yml'
  File.open(users_lib, 'w'){|f| f.write(friends.to_yaml) }
  puts "loaded #{i+1}: #{u}"

  # Twitter API limit: 15 per 15 minutes
  if (i+1 == 15)
    puts "(Twitter API limits 15 calls every 15 minutes)"
    puts "taking a 15-minute power nap..."

    clock =<<-SHELL
    MIN=15
    for i in $(seq $(($MIN*60)) -1 1);
      do
        printf "\r%02d:%02d:%02d" $((i/3600)) $(( (i/60)%60)) $((i%60));
        sleep 1;
      done
    SHELL
    system(clock)
    puts ""
  end
end
