defmodule ElixirExperience.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    [
    """
      CREATE TABLE users (
        id serial primary key,
        avatar_url text,
        email text,
        github_id bigint,
        login text
      )
    """,
    """
      CREATE UNIQUE INDEX ON users (github_id)
    """
    ]
  end

  def down do
    "DROP TABLE users"
  end
end
