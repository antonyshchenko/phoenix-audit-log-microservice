defmodule BusinessAuditLog.Web.LogEntryControllerTest do
  use BusinessAuditLog.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Business audit log"
  end
end
