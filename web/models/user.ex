defmodule ElixirExperience.User do
  use Ecto.Model
  import Ecto.Query, only: [from: 2]

  alias ElixirExperience.Repo
  alias ElixirExperience.User
  alias ElixirExperience.UserSolution

  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :github_id, :integer
    field :login, :string

    timestamps

    has_many :user_solutions, UserSolution
  end

  def create_solution(user, problem, code) do
    user_solution = %UserSolution{
      user_id: user.id,
      problem_number: problem.number,
      code: String.strip(code),
    }
    Repo.insert(user_solution)
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
      where: u.id == ^id,
      preload: [:user_solutions]

    Repo.one(query)
  end

  def solved?(user, problem) do
    if user do
      query = from s in UserSolution,
        where: s.user_id == ^user.id,
        where: s.problem_number == ^problem.number

      Repo.one(query) != nil
    else
      false
    end
  end
end
