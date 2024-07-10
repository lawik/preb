defmodule Preb.BuildsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Preb.Builds` context.
  """

  @doc """
  Generate a package_build.
  """
  def package_build_fixture(attrs \\ %{}) do
    {:ok, package_build} =
      attrs
      |> Enum.into(%{
        arch: "some arch",
        built_at: ~U[2024-07-09 11:03:00Z],
        elixir_version: "some elixir_version",
        errors: "some errors",
        gcc_version: "some gcc_version",
        libc: "some libc",
        mix_env: "some mix_env",
        os: "some os",
        otp_version: "some otp_version",
        package_name: "some package_name",
        package_type: "some package_type",
        package_version: "some package_version",
        published_at: ~U[2024-07-09 11:03:00Z],
        queued_at: ~U[2024-07-09 11:03:00Z]
      })
      |> Preb.Builds.create_package_build()

    package_build
  end
end
