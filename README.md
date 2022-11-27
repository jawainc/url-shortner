# URL shortener with Elixir and Phoenix

The technology stack consists following technologies, `Elixir`, `Phoenix framework`, `Liveviews` and `PostgreSQL`.

## Features
  * User is able to create new link
  * User is able to navigate to created link and redirected to original URL
  * Able to review statistics of the created link

## Initial setup
makesure you have the following
* [Elixir](https://elixir-lang.org/install.html), version 1.4 or later
* [Phoenix](https://hexdocs.pm/phoenix/1.7.0-rc.0/installation.html)
* [Postgres](https://www.postgresql.org/download/)


## How to setup and run

* Clone this repo.
* cd into the directory
* Make sure you have same elixir version as defined in `mix.exs`, otherwise change the elixir version to installed version in the file
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
* visit local site at http://localhost:4000
* Test with `mix test`

## Deployment on Gigalixir

Before deployment clone the project in another directory. To avoid deployemnt errors make sure you dont setup the project mix commands.

** on windows if there are deployment errors, use Linux or MAC. its a common problem with windows

* Use the official guide for [Deploying on gigalixir](https://hexdocs.pm/phoenix/1.7.0-rc.0/gigalixir.html)
* Dont miss any step, its crucial for deployment
