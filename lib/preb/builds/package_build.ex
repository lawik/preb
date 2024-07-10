defmodule Preb.Builds.PackageBuild do
  use Ecto.Schema
  import Ecto.Changeset

  schema "package_builds" do
    field :os, :string
    field :errors, :string
    field :elixir_version, :string
    field :otp_version, :string
    field :arch, :string
    field :package_name, :string
    field :package_version, :string
    field :package_type, :string
    field :gcc_version, :string
    field :libc, :string
    field :mix_env, :string
    field :queued_at, :utc_datetime
    field :built_at, :utc_datetime
    field :published_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(package_build, attrs) do
    package_build
    |> cast(attrs, [:package_name, :package_version, :package_type, :elixir_version, :otp_version, :arch, :os, :gcc_version, :libc, :mix_env, :queued_at, :built_at, :published_at, :errors])
    |> validate_required([:package_name, :package_version, :package_type, :elixir_version, :otp_version, :arch, :os, :gcc_version, :libc, :mix_env, :queued_at, :built_at, :published_at, :errors])
  end
end
