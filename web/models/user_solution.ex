defmodule ElixirExperience.UserSolution do
  use Ecto.Model

  schema "user_solutions" do
    field :problem_number, :integer
    field :code, :string

    belongs_to :user, User
  end
end
