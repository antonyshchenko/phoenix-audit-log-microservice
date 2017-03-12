defmodule BusinessAuditLog.Web.Api.LogEntryController do
  use BusinessAuditLog.Web, :controller

  alias BusinessAuditLog.AuditLog
  alias BusinessAuditLog.AuditLog.LogEntry

  action_fallback BusinessAuditLog.Web.FallbackController

  def index(conn, _params) do
    entries = AuditLog.list_entries()
    render(conn, "index.json", entries: entries)
  end
end
