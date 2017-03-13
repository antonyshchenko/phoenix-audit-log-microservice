defmodule BusinessAuditLog.Web.Api.LogEntryControllerTest do
  use BusinessAuditLog.Web.ConnCase

  alias BusinessAuditLog.AuditLog

  def fixture(:log_entry, attrs) do
    {:ok, log_entry} = AuditLog.create_log_entry(attrs)
    log_entry
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    entry = fixture(:log_entry, %{action: "some action",
                                  actor_id: "1",
                                  actor_type: "user",
                                  resource_id: "2",
                                  resource_type: "user"})

    conn = get conn, api_log_entry_path(conn, :index, :user, "2")

    assert json_response(conn, 200) == %{
      "entries" => [%{
        "id" => entry.id,
        "action" => "some action",
        "actor_id" => "1",
        "actor_type" => "user",
        "resource_id" => "2",
        "resource_type" => "user"
      }],
      "page_number" => 1,
      "page_size" => 10,
      "total_entries" => 1,
      "total_pages" => 1
    }
  end
end
