defmodule Preb.BuildsTest do
  use Preb.DataCase

  alias Preb.Builds

  describe "package_builds" do
    alias Preb.Builds.PackageBuild

    import Preb.BuildsFixtures

    @invalid_attrs %{os: nil, errors: nil, elixir_version: nil, otp_version: nil, arch: nil, package_name: nil, package_version: nil, package_type: nil, gcc_version: nil, libc: nil, mix_env: nil, queued_at: nil, built_at: nil, published_at: nil}

    test "list_package_builds/0 returns all package_builds" do
      package_build = package_build_fixture()
      assert Builds.list_package_builds() == [package_build]
    end

    test "get_package_build!/1 returns the package_build with given id" do
      package_build = package_build_fixture()
      assert Builds.get_package_build!(package_build.id) == package_build
    end

    test "create_package_build/1 with valid data creates a package_build" do
      valid_attrs = %{os: "some os", errors: "some errors", elixir_version: "some elixir_version", otp_version: "some otp_version", arch: "some arch", package_name: "some package_name", package_version: "some package_version", package_type: "some package_type", gcc_version: "some gcc_version", libc: "some libc", mix_env: "some mix_env", queued_at: ~U[2024-07-09 11:03:00Z], built_at: ~U[2024-07-09 11:03:00Z], published_at: ~U[2024-07-09 11:03:00Z]}

      assert {:ok, %PackageBuild{} = package_build} = Builds.create_package_build(valid_attrs)
      assert package_build.os == "some os"
      assert package_build.errors == "some errors"
      assert package_build.elixir_version == "some elixir_version"
      assert package_build.otp_version == "some otp_version"
      assert package_build.arch == "some arch"
      assert package_build.package_name == "some package_name"
      assert package_build.package_version == "some package_version"
      assert package_build.package_type == "some package_type"
      assert package_build.gcc_version == "some gcc_version"
      assert package_build.libc == "some libc"
      assert package_build.mix_env == "some mix_env"
      assert package_build.queued_at == ~U[2024-07-09 11:03:00Z]
      assert package_build.built_at == ~U[2024-07-09 11:03:00Z]
      assert package_build.published_at == ~U[2024-07-09 11:03:00Z]
    end

    test "create_package_build/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Builds.create_package_build(@invalid_attrs)
    end

    test "update_package_build/2 with valid data updates the package_build" do
      package_build = package_build_fixture()
      update_attrs = %{os: "some updated os", errors: "some updated errors", elixir_version: "some updated elixir_version", otp_version: "some updated otp_version", arch: "some updated arch", package_name: "some updated package_name", package_version: "some updated package_version", package_type: "some updated package_type", gcc_version: "some updated gcc_version", libc: "some updated libc", mix_env: "some updated mix_env", queued_at: ~U[2024-07-10 11:03:00Z], built_at: ~U[2024-07-10 11:03:00Z], published_at: ~U[2024-07-10 11:03:00Z]}

      assert {:ok, %PackageBuild{} = package_build} = Builds.update_package_build(package_build, update_attrs)
      assert package_build.os == "some updated os"
      assert package_build.errors == "some updated errors"
      assert package_build.elixir_version == "some updated elixir_version"
      assert package_build.otp_version == "some updated otp_version"
      assert package_build.arch == "some updated arch"
      assert package_build.package_name == "some updated package_name"
      assert package_build.package_version == "some updated package_version"
      assert package_build.package_type == "some updated package_type"
      assert package_build.gcc_version == "some updated gcc_version"
      assert package_build.libc == "some updated libc"
      assert package_build.mix_env == "some updated mix_env"
      assert package_build.queued_at == ~U[2024-07-10 11:03:00Z]
      assert package_build.built_at == ~U[2024-07-10 11:03:00Z]
      assert package_build.published_at == ~U[2024-07-10 11:03:00Z]
    end

    test "update_package_build/2 with invalid data returns error changeset" do
      package_build = package_build_fixture()
      assert {:error, %Ecto.Changeset{}} = Builds.update_package_build(package_build, @invalid_attrs)
      assert package_build == Builds.get_package_build!(package_build.id)
    end

    test "delete_package_build/1 deletes the package_build" do
      package_build = package_build_fixture()
      assert {:ok, %PackageBuild{}} = Builds.delete_package_build(package_build)
      assert_raise Ecto.NoResultsError, fn -> Builds.get_package_build!(package_build.id) end
    end

    test "change_package_build/1 returns a package_build changeset" do
      package_build = package_build_fixture()
      assert %Ecto.Changeset{} = Builds.change_package_build(package_build)
    end
  end
end
