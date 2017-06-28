defmodule SimpleAuth.UserTest do
  use SimpleAuth.ModelCase

  alias SimpleAuth.User

  @valid_attrs %{email: "foo@bar.com", name: "some content", password: "123456"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "registration_changeset, password ok" do
      changeset = User.registration_changeset(%User{}, @valid_attrs)
      assert changeset.changes.password_hash
      assert changeset.valid?
    end

    test "registration_changeset, password too short" do
      changeset = User.registration_changeset(
        %User{}, Map.put(@valid_attrs, :password, "12345")
      )
      refute changeset.valid?
    end

end
