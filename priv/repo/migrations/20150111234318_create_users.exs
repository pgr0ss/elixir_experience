defmodule ElixirExperience.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute """
      CREATE TABLE users (
        id serial primary key,
        avatar_url text,
        email text,
        github_id bigint,
        login text
      )
    """

    execute "CREATE UNIQUE INDEX ON users (github_id)"
  end

  def down do
    execute "DROP TABLE users"
  end
end
