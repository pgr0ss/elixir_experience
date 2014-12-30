defmodule ElixirExperience.DockerTest do
  use ExSpec, async: true

  alias ElixirExperience.Docker

  describe "run" do
    it "runs a bad code and captures output" do
      {output, exit_code} = Docker.run("garbage")
      assert exit_code == 1
      assert output == "** (CompileError) nofile:1: undefined function garbage/0\n    (elixir) lib/code.ex:140: Code.eval_string/3"
    end

    it "runs code and captures output" do
      {output, exit_code} = Docker.run("Enum.join(1..5, \",\") |> IO.inspect")
      assert exit_code == 0
      assert output == "\"1,2,3,4,5\""
    end

    it "does not block longer than timeout" do
      {output, exit_code} = Docker.run(":timer.sleep(1000)", 10)
      assert exit_code == 124
      assert output == "Your code took longer than 0.01 seconds to run"
    end

    it "has no access to the network" do
      code = """
      :inets.start
      {:ok, result} = :httpc.request(:get, {'http://google.com', []}, [], [])
      IO.puts elem(result, 2)
      """

      {output, exit_code} = Docker.run(code)
      assert exit_code == 1
      assert String.contains?(output, ":failed_connect")
    end
  end
end

defmodule ElixirExperience.DockerTestNotAsync do
  use ExSpec, async: false

  alias ElixirExperience.Docker

  describe "run" do
    it "cleans up temporary containers" do
      before_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count
      {_, 0} = Docker.run("")
      after_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count

      assert before_containers == after_containers
    end
  end
end
