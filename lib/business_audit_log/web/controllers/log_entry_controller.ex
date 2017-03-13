defmodule BusinessAuditLog.Web.LogEntryController do
  use BusinessAuditLog.Web, :controller
  alias BusinessAuditLog.AuditLog

  def index(conn, params) do
    log_entries_page = AuditLog.list_entries(page: params["page"] || 1, page_size: 5)
    render(conn, "index.html", log_entries_page: log_entries_page)
  end

  def tail(conn, params) do
    log_entries_page = AuditLog.list_entries(page: params["page"] || 1, page_size: 5)
    render(conn, "tail.html", log_entries_page: log_entries_page)
  end
end
