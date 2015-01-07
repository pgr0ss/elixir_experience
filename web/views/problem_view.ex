defmodule ElixirExperience.ProblemView do
  use ElixirExperience.View

  def markdown_to_html(question) do
    Earmark.to_html(question) |> Phoenix.HTML.safe
  end

end
