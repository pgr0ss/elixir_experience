defmodule ElixirExperience.ProblemTest do
  use ExSpec, async: true

  alias ElixirExperience.Problem

  describe "struct" do
    it "has fields" do
      problem = %Problem{number: 5, question: "some question"}
      assert problem.number == 5
      assert problem.question == "some question"
    end
  end

  describe "load_all" do
    it "loads the problems from disk" do
      problems = Problem.load_all
      assert Enum.count(problems) > 2

      first_problem = Enum.at(problems, 0)
      assert first_problem.number == 1
      assert String.starts_with?(first_problem.question, "<p>Write a function called add that takes two numbers and returns their sum, e.g.:</p>\n<pre><code class=\"elixir\">add(1, 2) #=&gt; 3</code></pre>")
    end

    it "creates a short question" do
      problems = Problem.load_all
      assert Enum.count(problems) > 2

      first_problem = Enum.at(problems, 0)
      assert first_problem.short_question == "Write a function called add that takes two numbers and returns their sum, e.g..."
    end
  end

  describe "short_question" do
    it "gives a short version of the first line" do
      question = "hello\nworld"
      assert Problem.short_question(question) == "hello..."
    end

    it "truncates the line" do
      question = String.duplicate("1234567890", 10)
      assert Problem.short_question(question) == String.duplicate("1234567890", 7) <> "1234567..."
    end
  end
end
