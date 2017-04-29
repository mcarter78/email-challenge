# The Email Challenge

A working demo of this app can be found at:

https://mighty-tor-53408.herokuapp.com/

This repo contains the Ruby on Rails backend, plus the production build of the React frontend in the `/public` folder.  The source code for the React frontend can be found at:

https://github.com/mcarter78/email-challenge-client/

To install the application locally, clone the repo and run `rake db:create`, `rake db:migrate`
, and `rake db:seed`.  Start up the application with `rails s`.

The seed file will add the following users to the database:

`db/seeds.rb`
```ruby
# Let's create some users
User.create(name: 'Matt', email: 'matt@example.com')
User.create(name: 'Bob', email: 'bob@example.com')
User.create(name: 'Susan', email: 'susan@example.com')
User.create(name: 'Karl', email: 'karl@example.com')
User.create(name: 'Angie', email: 'angie@example.com')

# Tokens are generated upon login, so we do not need to seed any
# But we'll give Bob a bad token for demonstration purposes
Token.create(user_id: 2, nonce: nil)
```

Login with any user to start making changes to the accounts.  Be wary of Bob though,
any changes he tries to make will be rejected!
