defmodule SimpleAuth.UserControllerTest do
  use SimpleAuth.ConnCase

  alias SimpleAuth.User
  @valid_attrs %{email: "foo@bar.com", name: "john smith", password: "s3cr3t"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "text/html")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    user = Repo.get_by(User, email: "foo@bar.com")
    assert redirected_to(conn) == "/users/#{user.id}"
    assert(
    conn
    |> Phoenix.Controller.get_flash("info")
    |> String.contains?("john smith created"))
    assert Repo.get_by(User, email: "foo@bar.com")
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert String.contains?(conn.resp_body, "can&#39;t be blank")
  end

end
