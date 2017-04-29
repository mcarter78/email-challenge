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
