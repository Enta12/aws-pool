defmodule Todolist.SchemasTest do
  use Todolist.DataCase

  alias Todolist.Schemas

  # describe "users" do
  #   alias Todolist.Schemas.User

  #   @valid_attrs %{email: "email@email.fr", username: "some username"}
  #   @update_attrs %{email: "updateemail@email.fr", username: "some updated username"}
  #   @invalid_attrs %{email: nil, username: nil}

  #   def user_fixture(attrs \\ %{}) do
  #     {:ok, user} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Schemas.create_user()

  #     user
  #   end

  #   test "list_users/0 returns all users" do
  #     user = user_fixture()
  #     assert Schemas.list_users() == [user]
  #   end

  #   test "get_user!/1 returns the user with given id" do
  #     user = user_fixture()
  #     assert Schemas.get_user!(user.id) == user
  #   end

  #   test "create_user/1 with valid data creates a user" do
  #     assert {:ok, %User{} = user} = Schemas.create_user(@valid_attrs)
  #     assert user.email == "email@email.fr"
  #     assert user.username == "some username"
  #   end

  #   test "create_user/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Schemas.create_user(@invalid_attrs)
  #   end

  #   test "update_user/2 with valid data updates the user" do
  #     user = user_fixture()
  #     assert {:ok, %User{} = user} = Schemas.update_user(user, @update_attrs)
  #     assert user.email == "updateemail@email.fr"
  #     assert user.username == "some updated username"
  #   end

  #   test "update_user/2 with invalid data returns error changeset" do
  #     user = user_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Schemas.update_user(user, @invalid_attrs)
  #     assert user == Schemas.get_user!(user.id)
  #   end

  #   test "delete_user/1 deletes the user" do
  #     user = user_fixture()
  #     assert {:ok, %User{}} = Schemas.delete_user(user)
  #     assert_raise Ecto.NoResultsError, fn -> Schemas.get_user!(user.id) end
  #   end

  #   # test "change_user/1 returns a user changeset" do
  #   #   user = user_fixture()
  #   #   assert %Ecto.Changeset{} = Schemas.change_user(user)
  #   # end
  # end

  # describe "clocks" do
  #   alias Todolist.Schemas.Clock

  #   @valid_attrs %{user_id: 1, status: true, time: ~N[2010-04-17 14:00:00]}
  #   @update_attrs %{status: false, time: ~N[2011-05-18 15:01:01]}
  #   @invalid_attrs %{user_id: nil, status: nil, time: nil}

  #   #user = user_fixture() add when we need a user

  #   def clock_fixture(attrs \\ %{}) do
  #     {:ok, clock} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Schemas.create_clock()

  #     clock
  #   end

  #   test "list_clocks/0 returns all clocks" do
  #     user = user_fixture()
  #     clock = clock_fixture(%{@valid_attrs | user_id: user.id})
  #     assert Schemas.list_clocks() == [clock]
  #   end

  #   test "get_clock!/1 returns the clock with given id" do
  #     user = user_fixture()
  #     clock = clock_fixture(%{@valid_attrs | user_id: user.id})
  #     assert Schemas.get_clock!(clock.id) == clock
  #   end

  #   test "create_clock/1 with valid data creates a clock" do
  #     user = user_fixture()
  #     assert {:ok, %Clock{} = clock} = Schemas.create_clock(%{@valid_attrs | user_id: user.id})
  #     assert clock.status == true
  #     assert clock.time == ~N[2010-04-17 14:00:00]
  #   end

  #   test "create_clock/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Schemas.create_clock(@invalid_attrs)
  #   end

  #   test "update_clock/2 with valid data updates the clock" do
  #     user = user_fixture()
  #     clock = clock_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:ok, %Clock{} = clock} = Schemas.update_clock(clock, @update_attrs)
  #     assert clock.status == false
  #     assert clock.time == ~N[2011-05-18 15:01:01]
  #   end

  #   test "update_clock/2 with invalid data returns error changeset" do
  #     user = user_fixture()
  #     clock = clock_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:error, %Ecto.Changeset{}} = Schemas.update_clock(clock, @invalid_attrs)
  #     assert clock == Schemas.get_clock!(clock.id)
  #   end

  #   test "delete_clock/1 deletes the clock" do
  #     user = user_fixture()
  #     clock = clock_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:ok, %Clock{}} = Schemas.delete_clock(clock)
  #     assert_raise Ecto.NoResultsError, fn -> Schemas.get_clock!(clock.id) end
  #   end

  #   # test "change_clock/1 returns a clock changeset" do
  #   #   clock = clock_fixture()
  #   #   assert %Ecto.Changeset{} = Schemas.change_clock(clock)
  #   # end
  # end

  # describe "workingtimes" do
  #   alias Todolist.Schemas.Workingtime

  #   @valid_attrs %{user_id: 0, end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
  #   @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
  #   @invalid_attrs %{user_id: nil, end: nil, start: nil}

  #   def workingtime_fixture(attrs \\ %{}) do
  #     {:ok, workingtime} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Schemas.create_workingtime()

  #     workingtime
  #   end

  #   test "list_workingtimes/1 returns all workingtimes" do
  #     user = user_fixture()
  #     workingtime = workingtime_fixture(%{@valid_attrs | user_id: user.id})
  #     assert Schemas.list_workingtimes(user.id) == [workingtime]
  #   end

  #   test "get_workingtime!/1 returns the workingtime with given id" do
  #     user = user_fixture()
  #     workingtime = workingtime_fixture(%{@valid_attrs | user_id: user.id})
  #     assert Schemas.get_workingtime!(workingtime.id) == workingtime
  #   end

  #   test "create_workingtime/1 with valid data creates a workingtime" do
  #     user = user_fixture()
  #     assert {:ok, %Workingtime{} = workingtime} = Schemas.create_workingtime(%{@valid_attrs | user_id: user.id})
  #     assert workingtime.end == ~N[2010-04-17 14:00:00]
  #     assert workingtime.start == ~N[2010-04-17 14:00:00]
  #   end

  #   test "create_workingtime/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Schemas.create_workingtime(@invalid_attrs)
  #   end

  #   test "update_workingtime/2 with valid data updates the workingtime" do
  #     user = user_fixture()
  #     workingtime = workingtime_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:ok, %Workingtime{} = workingtime} = Schemas.update_workingtime(workingtime, @update_attrs)
  #     assert workingtime.end == ~N[2011-05-18 15:01:01]
  #     assert workingtime.start == ~N[2011-05-18 15:01:01]
  #   end

  #   test "update_workingtime/2 with invalid data returns error changeset" do
  #     user = user_fixture()
  #     workingtime = workingtime_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:error, %Ecto.Changeset{}} = Schemas.update_workingtime(workingtime, @invalid_attrs)
  #     assert workingtime == Schemas.get_workingtime!(workingtime.id)
  #   end

  #   test "delete_workingtime/1 deletes the workingtime" do
  #     user = user_fixture()
  #     workingtime = workingtime_fixture(%{@valid_attrs | user_id: user.id})
  #     assert {:ok, %Workingtime{}} = Schemas.delete_workingtime(workingtime)
  #     assert_raise Ecto.NoResultsError, fn -> Schemas.get_workingtime!(workingtime.id) end
  #   end

  #   # test "change_workingtime/1 returns a workingtime changeset" do
  #   #   workingtime = workingtime_fixture()
  #   #   assert %Ecto.Changeset{} = Schemas.change_workingtime(workingtime)
  #   # end
  # end

  # describe "roles" do
  #   alias Todolist.Schemas.Role

  #   @valid_attrs %{name: "some name"}
  #   @update_attrs %{name: "some updated name"}
  #   @invalid_attrs %{name: nil}

  #   def role_fixture(attrs \\ %{}) do
  #     {:ok, role} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Schemas.create_role()

  #     role
  #   end

  #   test "list_roles/0 returns all roles" do
  #     role = role_fixture()
  #     assert Schemas.list_roles() == [role]
  #   end

  #   test "get_role!/1 returns the role with given id" do
  #     role = role_fixture()
  #     assert Schemas.get_role!(role.id) == role
  #   end

  #   test "create_role/1 with valid data creates a role" do
  #     assert {:ok, %Role{} = role} = Schemas.create_role(@valid_attrs)
  #     assert role.name == "some name"
  #   end

  #   test "create_role/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Schemas.create_role(@invalid_attrs)
  #   end

  #   test "update_role/2 with valid data updates the role" do
  #     role = role_fixture()
  #     assert {:ok, %Role{} = role} = Schemas.update_role(role, @update_attrs)
  #     assert role.name == "some updated name"
  #   end

  #   test "update_role/2 with invalid data returns error changeset" do
  #     role = role_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Schemas.update_role(role, @invalid_attrs)
  #     assert role == Schemas.get_role!(role.id)
  #   end

  #   test "delete_role/1 deletes the role" do
  #     role = role_fixture()
  #     assert {:ok, %Role{}} = Schemas.delete_role(role)
  #     assert_raise Ecto.NoResultsError, fn -> Schemas.get_role!(role.id) end
  #   end

  #   test "change_role/1 returns a role changeset" do
  #     role = role_fixture()
  #     assert %Ecto.Changeset{} = Schemas.change_role(role)
  #   end
  # end
end
