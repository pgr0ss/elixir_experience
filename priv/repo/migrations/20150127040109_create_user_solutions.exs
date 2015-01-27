defmodule ElixirExperience.Repo.Migrations.CreateUserSolutions do
  use Ecto.Migration

  def up do
    execute """
      CREATE TABLE user_solutions (
        id serial PRIMARY KEY,
        user_id integer NOT NULL REFERENCES users (id),
        problem_number integer NOT NULL,
        code text NOT NULL,
        inserted_at timestamp NOT NULL,
        updated_at timestamp NOT NULL
      )
    """

    execute "CREATE INDEX ON user_solutions (user_id)"
  end

  def down do
    execute "DROP TABLE user_solutions"
  end
end
