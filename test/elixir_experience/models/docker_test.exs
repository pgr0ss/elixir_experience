defmodule ElixirExperience.DockerTest do
  use ExSpec, async: true

  alias ElixirExperience.Docker

  describe "run" do
    it "runs a simple elixir command" do
      {output, exit_code} = Docker.run("IO.puts(42)")
      assert exit_code == 0
      assert output == "42"
    end

    it "runs a bad command and captures output" do
      {output, exit_code} = Docker.run("garbage")
      assert exit_code == 1
      assert String.contains?(output, "undefined function garbage/0")
    end

    it "does not block longer than 2 seconds" do
      {output, exit_code} = Docker.run(":timer.sleep(3000)")
      assert exit_code == 124
      assert String.contains?(output, "")
    end

    it "can run a multiline elixir command" do
      code = """
        x = "hello"
        y = "world"
        z = x <> " " <> y
        IO.puts(z)
      """
      {output, exit_code} = Docker.run(code)
      assert exit_code == 0
      assert output == "hello world"
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

    it "cleans up temporary containers" do
      before_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count
      {_, 0} = Docker.run("")
      after_containers = System.cmd("docker", ["ps", "--all", "--quiet"]) |> elem(0) |> String.split |> Enum.count
      assert before_containers == after_containers
    end
  end
end
