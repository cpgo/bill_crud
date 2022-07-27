FROM elixir:1.13.4-otp-25

# Create app directory and copy the Elixir projects into it.
RUN apt-get update && \
  apt-get install -y postgresql-client inotify-tools

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install Hex package manager.
RUN mix local.hex --force

# Compile the project.
RUN mix deps.get
RUN mix compile

CMD ["/app/entrypoint.sh"]
