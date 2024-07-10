defmodule Preb.Builds do
  @moduledoc """
  The Builds context.
  """

  import Ecto.Query, warn: false
  alias Preb.Repo

  alias Preb.Builds.PackageBuild

  alias DepsPrebuild.Build

  def from_build(%Build{} = build) do
    build
    |> Map.from_struct()
    |> create_package_build()
  end

  @doc """
  Returns the list of package_builds.

  ## Examples

      iex> list_package_builds()
      [%PackageBuild{}, ...]

  """
  def list_package_builds do
    Repo.all(PackageBuild)
  end

  @doc """
  Gets a single package_build.

  Raises `Ecto.NoResultsError` if the Package build does not exist.

  ## Examples

      iex> get_package_build!(123)
      %PackageBuild{}

      iex> get_package_build!(456)
      ** (Ecto.NoResultsError)

  """
  def get_package_build!(id), do: Repo.get!(PackageBuild, id)

  @doc """
  Creates a package_build.

  ## Examples

      iex> create_package_build(%{field: value})
      {:ok, %PackageBuild{}}

      iex> create_package_build(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_package_build(attrs \\ %{}) do
    %PackageBuild{}
    |> PackageBuild.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a package_build.

  ## Examples

      iex> update_package_build(package_build, %{field: new_value})
      {:ok, %PackageBuild{}}

      iex> update_package_build(package_build, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_package_build(%PackageBuild{} = package_build, attrs) do
    package_build
    |> PackageBuild.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a package_build.

  ## Examples

      iex> delete_package_build(package_build)
      {:ok, %PackageBuild{}}

      iex> delete_package_build(package_build)
      {:error, %Ecto.Changeset{}}

  """
  def delete_package_build(%PackageBuild{} = package_build) do
    Repo.delete(package_build)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking package_build changes.

  ## Examples

      iex> change_package_build(package_build)
      %Ecto.Changeset{data: %PackageBuild{}}

  """
  def change_package_build(%PackageBuild{} = package_build, attrs \\ %{}) do
    PackageBuild.changeset(package_build, attrs)
  end
end
