defmodule SimpleAuth.SessionControllerTest do
  use SimpleAuth.ConnCase

  alias SimpleAuth.Session

  @valid_login_attrs %{ email: "foo@bar.com", password: "s3cr3t"}
  @invalid_login_attrs %{ email: "foo@bar.com", password: "r3t" }

  @valid_attrs %{email: "foo@bar.com", name: "john smith", password: "s3cr3t"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "text/html")}
  end

  test "user session is created with successful login", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    conn = post conn, session_path(conn, :create), session: @valid_login_attrs

    assert redirected_to(conn) == "/"
    assert(
    conn
    |> Phoenix.Controller.get_flash("info")
    |> String.contains?("now logged in!"))
  end

  test "does not log user in with invalid credentials", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    conn = post conn, session_path(conn, :create), session: @invalid_login_attrs
    assert String.contains?(conn.private[:phoenix_flash]["error"], "Invalid email/password combination")
  end

end
