defmodule ElixirExperience.User do
  use Ecto.Model
  import Ecto.Query, only: [from: 2]

  alias ElixirExperience.Repo
  alias ElixirExperience.User

  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :github_id, :integer
    field :login, :string
  end

  def insert_unless_exists(user) do
    find_by_github_id(user.github_id) || Repo.insert(user)
  end

  def find_by_github_id(github_id) do
    query = from u in User,
      where: u.github_id == ^github_id

    Repo.one(query)
  end

  def find_by_id(id) do
    query = from u in User,
      where: u.id == ^id

    Repo.one(query)
  end
end
