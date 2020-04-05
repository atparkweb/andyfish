defmodule AndyFish.AccountsTest do
  use AndyFish.DataCase, async: true

  alias AndyFish.Accounts
  alias AndyFish.Accounts.User

  @valid_attrs %{
    email: "someone@example.com",
    name: "some name",
    password: "some password"}
  @invalid_attrs %{
    email: nil,
    name: nil,
    password: nil}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.register_user()

    user
  end

  test "register_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Accounts.register_user(@valid_attrs)
    assert user.email == "someone@example.com"
    assert user.name == "some name"
  end

  test "register_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.register_user(@invalid_attrs)
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

  test "enforces unique emails" do
    assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
    assert {:error, changeset} = Accounts.register_user(@valid_attrs)
    assert %{email: ["has already been taken"]} = errors_on(changeset)
    assert [%User{id: ^id}] = Accounts.list_users()
  end

  test "requires password to be at least 7 characters long" do
    attrs = Map.put(@valid_attrs, :password, "123456")
    {:error, changeset} = Accounts.register_user(attrs)
    assert %{password: ["should be at least 7 character(s)"]} = errors_on(changeset)
    assert Accounts.list_users() == []
  end

  describe "authenticates user by password and email" do
    @pass "1234567"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} = Accounts.authenticate_by_email_password(user.email, @pass)
      assert auth_user.id == user.id
    end
    
    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} = Accounts.authenticate_by_email_password(user.email, "wrongpass")
    end
    
    test "returns not found error with no matching user for email" do
      assert {:error, :not_found} = Accounts.authenticate_by_email_password("bad@example.com", @pass)
    end
  end
end
