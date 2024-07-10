defmodule Preb.Orchestrator do
  use GenServer

  alias DepsPrebuild.Build

  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    state = %{
      page: 1,
      packages: []
    }

    {:ok, state, {:continue, :search}}
  end

  def handle_continue(:search, state) do
    {:ok, result} = DepsPrebuild.search("", state.page)

    {:noreply, %{state | packages: state.packages ++ result, page: state.page + 1},
     {:continue, :build}}
  end

  def handle_continue(:build, state) do
    DepsPrebuild.build_matrix(
      elixir_versions(),
      otp_versions(),
      arches(),
      oses(),
      gcc_versions(),
      libcs(),
      mix_envs()
    )
    |> Enum.map(fn {tag, %Build{} = b} ->
      Logger.info("Building for: #{tag}")
      five_min = 1000 * 60 * 5

      find_nodes()
      |> Enum.map(fn node_info ->
        if node_info.os == b.os and node_info.arch == b.arch do
          Enum.map(state.packages, fn %{
                                        "name" => package_name,
                                        "latest_stable_version" => package_version
                                      } ->
            b =
              b
              |> Build.set_base_dir("/tmp")
              |> DepsPrebuild.with_package(package_name, package_version)

            Preb.Builds.from_build(b)
            Phoenix.PubSub.broadcast(Preb.PubSub, "builds", {:build, b})

            :erpc.call(
              node_info.node_id,
              fn ->
                DepsPrebuild.download_and_build(b)
              end,
              five_min
            )
          end)
        end
      end)
    end)

    {:noreply, %{state | packages: []}, {:continue, :search}}
  end

  def gcc_versions do
    ["v13.2.0"]
  end

  def mix_envs do
    [:dev, :test, :prod]
  end

  def libcs do
    [:gnu]
  end

  def elixir_versions do
    ["1.17.1"]
  end

  def otp_versions do
    ["26.2.5.1"]
  end

  def arches do
    [:aarch64]
  end

  def oses do
    [:macos]
  end

  def find_nodes do
    [
      %{
        node_id: Node.self(),
        os: :macos,
        arch: :aarch64
      }
    ]
  end
end
