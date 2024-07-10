defmodule Preb.Repo.Migrations.CreatePackageBuilds do
  use Ecto.Migration

  def change do
    create table(:package_builds) do
      add :package_name, :string
      add :package_version, :string
      add :package_type, :string
      add :elixir_version, :string
      add :otp_version, :string
      add :arch, :string
      add :os, :string
      add :gcc_version, :string
      add :libc, :string
      add :mix_env, :string
      add :queued_at, :utc_datetime
      add :built_at, :utc_datetime
      add :published_at, :utc_datetime
      add :errors, :string

      timestamps(type: :utc_datetime)
    end
  end
end
