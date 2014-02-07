# FakeFriends

[![Gem Version](https://badge.fury.io/rb/fake_friends.png)](http://badge.fury.io/rb/fake_friends)
[![Code Climate](https://codeclimate.com/github/jmromer/FakeFriends.png)](https://codeclimate.com/github/jmromer/FakeFriends)
[![Build Status](https://travis-ci.org/jmromer/FakeFriends.png?branch=master)](https://travis-ci.org/jmromer/FakeFriends)

A simple [ruby gem](https://rubygems.org/gems/fake_friends) to generate consistent and realistic fake user data for demoing social networking apps (e.g., user names match their avatars, fake posts are pulled from actual Twitter posts rather than lorem text, etc), modeled on the popular [Faker](https://github.com/stympy/faker) gem.


## Release Notes
**1.0.0** Rewrites fetch script and updates it for Twitter API v1.1 (backwards incompatible), minor bug fixed
**0.1.6** Adds tests in RSpec
**0.1.5** Inital release


## Installation

Add this line to your application's Gemfile: `gem 'fake_friends'`
And then execute: `$ bundle`
Or install it yourself as: `$ gem install fake_friends`


## The FakeFriend class

#### class methods
* `::gather(n)`
  `n`: int (number of user objects to create)
* `::find_by(options)`
  `options`: { `username:` string (twitter username) } or { `id:` int (from 1 to 101) }

#### instance methods
* `#username`
* `#name`
* `#description`
* `#avatar_url(size)`
  `size`: requested size of image. Available in 128, 73, 48, and 24 px.
   Returns a url to an image in the closest available size.
* `#url`
* `#posts`

## Usage

With `include FakeFriends` assumed, use

    FakeFriend.gather(5)

to return an array of 5 `FakeFriend` objects.

    user = FakeFriend.find_by(id: 5)

returns the fifth user in the library and assigns it to `user`.

`user.avatar_url(size)` pulls an avatar from uiFaces.com, where Twitter users have contributed their profile photos.
The available sizes (in pixels) are 128, 73, 48, and 24. The method will choose the image closest in size
to the requested `size`.

`user.url` returns a hash with an `:expanded` url (e.g. `http://www.google.com`) and a `:display` url (e.g. `google.com`).

`user.posts` returns an array of `user`'s status updates.


## Data

The library currently holds 101 users with associated status updates. Associated image urls are generated from the username.

## Source
Images come from user contributions on uiFaces.com.
Posts are non-retweet tweets from the associated twitter profiles (all public).
Many thanks to these users for their contributions.


## Future work

A hundred users should be enough for most demoing needs, but a class method to fetch fresh data from the Twitter API may be added in future. The script used to fetch data from the Twitter API is included in the `dev` folder.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
