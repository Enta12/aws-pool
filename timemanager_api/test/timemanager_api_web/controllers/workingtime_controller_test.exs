defmodule TodolistWeb.WorkingtimeControllerTest do
  use TodolistWeb.ConnCase

  alias TodolistWeb.UserControllerTest
  alias Todolist.Schemas
  alias Todolist.Schemas.Workingtime

  # @create_attrs %{
  #   end: ~N[2010-04-17 14:00:00],
  #   start: ~N[2010-04-17 14:00:00],
  #   user_id: 0
  # }
  # @update_attrs %{
  #   end: ~N[2011-05-18 15:01:01],
  #   start: ~N[2011-05-18 15:01:01],
  # }
  # @invalid_attrs %{
  #   end: nil,
  #   start: nil,
  #   user_id: nil
  # }

  # @invalid_attrs %{end: nil, start: nil}

  # def fixture(:workingtime) do
  #   user = UserControllerTest.fixture(:user)
  #   {:ok, workingtime} = Schemas.create_workingtime(%{@create_attrs | user_id: user.id} )
  #   workingtime
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # # describe "index" do
  # #   test "lists all workingtimes", %{conn: conn} do
  # #     conn = get(conn, Routes.workingtime_path(conn, :index))
  # #     assert json_response(conn, 200)["data"] == []
  # #   end
  # # end

  # # describe "create workingtime" do
  # #   test "renders workingtime when data is valid", %{conn: conn} do
  # #     user = UserControllerTest.fixture(:user)

  # #     conn = post(conn, Routes.workingtime_path(conn, :create, user.id), %{
  # #     workingtime: @create_attrs,
  # #     userID: user.id
  # #     })

  # #     assert %{"id" => id} = json_response(conn, 201)["data"]

  # #     conn = get(conn, Routes.workingtime_path(conn, :show, user.id, id))

  # #     assert %{
  # #     "id" => id,
  # #     "end" => "2010-04-17T14:00:00",
  # #     "start" => "2010-04-17T14:00:00"
  # #     } = json_response(conn, 200)["data"]
  # #     end

  # #   test "renders errors when data is invalid", %{conn: conn} do
  # #     user = UserControllerTest.fixture(:user)
  # #     conn = post(conn, Routes.workingtime_path(conn, :create, user.id), workingtime: @invalid_attrs)
  # #     assert json_response(conn, 422)["errors"] != %{}
  # #   end
  # # end

  # describe "update workingtime" do
  #   setup [:create_workingtime]

  #   test "renders errors when data is invalid", %{conn: conn, workingtime: workingtime} do
  #     conn = put(conn, Routes.workingtime_path(conn, :update, workingtime.id), workingtime: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete workingtime" do
  #   setup [:create_workingtime]

  #   test "deletes chosen workingtime", %{conn: conn, workingtime: workingtime} do
  #     conn = delete(conn, Routes.workingtime_path(conn, :delete, workingtime.id))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.workingtime_path(conn, :show, workingtime.user_id, workingtime.id))
  #     end
  #   end
  # end

  # defp create_workingtime(_) do
  #   workingtime = fixture(:workingtime)
  #   %{workingtime: workingtime}
  # end
end
