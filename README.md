# Elixir Experience

This is an interactive website for learning elixir. You can see it in action at:

http://elixirexperience.com

## Running locally

### Install Docker

Follow the instructions at https://www.docker.com

If you use OS X, use boot2docker and ensure that you run `$(boot2docker shellinit)` in the terminal

### Install PostgreSQL

On OS X, `brew install postgresql`

### Running

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Create and migration the database with `mix db.reset`
3. Start Phoenix with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

### Testing

Run the tests locally with `mix test`

## Contributing
Please see [CONTRIBUTING.md](CONTRIBUTING.md)
