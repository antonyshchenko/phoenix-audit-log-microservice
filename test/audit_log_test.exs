defmodule BusinessAuditLog.AuditLogTest do
  use BusinessAuditLog.DataCase

  alias BusinessAuditLog.AuditLog
  alias BusinessAuditLog.AuditLog.LogEntry

  @create_attrs %{action: "some action", actor_id: "some actor_id", actor_type: "some actor_type", resource_id: "some resource_id", resource_type: "some resource_type"}
  @update_attrs %{action: "some updated action", actor_id: "some updated actor_id", actor_type: "some updated actor_type", resource_id: "some updated resource_id", resource_type: "some updated resource_type"}
  @invalid_attrs %{action: nil, actor_id: nil, actor_type: nil, resource_id: nil, resource_type: nil}

  def fixture(:log_entry, attrs \\ @create_attrs) do
    {:ok, log_entry} = AuditLog.create_log_entry(attrs)
    log_entry
  end

  test "list_entries/1 returns all entries" do
    log_entry = fixture(:log_entry)
    assert AuditLog.list_entries(%{page: 1, page_size: 10}) ==
      %Scrivener.Page{
        entries: [log_entry],
        page_number: 1,
        page_size: 10,
        total_entries: 1,
        total_pages: 1
      }
  end

  test "create_log_entry/1 with valid data creates a log_entry" do
    assert {:ok, %LogEntry{} = log_entry} = AuditLog.create_log_entry(@create_attrs)

    assert log_entry.action == "some action"
    assert log_entry.actor_id == "some actor_id"
    assert log_entry.actor_type == "some actor_type"
    assert log_entry.resource_id == "some resource_id"
    assert log_entry.resource_type == "some resource_type"
  end

  test "create_log_entry/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = AuditLog.create_log_entry(@invalid_attrs)
  end
end
