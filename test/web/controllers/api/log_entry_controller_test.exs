defmodule BusinessAuditLog.Web.Api.LogEntryControllerTest do
  use BusinessAuditLog.Web.ConnCase

  alias BusinessAuditLog.AuditLog
  alias BusinessAuditLog.AuditLog.LogEntry

  @create_attrs %{action: "some action", actor_id: "some actor_id", actor_type: "some actor_type", resource_id: "some resource_id", resource_type: "some resource_type"}
  @update_attrs %{action: "some updated action", actor_id: "some updated actor_id", actor_type: "some updated actor_type", resource_id: "some updated resource_id", resource_type: "some updated resource_type"}
  @invalid_attrs %{action: nil, actor_id: nil, actor_type: nil, resource_id: nil, resource_type: nil}

  def fixture(:log_entry) do
    {:ok, log_entry} = AuditLog.create_log_entry(@create_attrs)
    log_entry
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_log_entry_path(conn, :index, :user, "123")
    assert json_response(conn, 200)["data"] == []
  end
end
