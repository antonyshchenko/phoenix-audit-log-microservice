defmodule BusinessAuditLog.Web.TailChannel do
  use Phoenix.Channel
  alias BusinessAuditLog.Web.Endpoint
  alias BusinessAuditLog.Web.Api.LogEntryView
  alias BusinessAuditLog.AuditLog

  def join("log_tail", _message, socket) do
    last_entries = AuditLog.list_entries(page_size: 10)
    payload = Enum.map(last_entries, &(serialize_log_entry(&1)))
    {:ok, payload, socket}
  end

  def broadcast_new_entry(log_entry) do
    Endpoint.broadcast("log_tail", "new_entry", serialize_log_entry(log_entry))
    {:ok, log_entry}
  end

  defp serialize_log_entry(log_entry) do
    LogEntryView.render("log_entry.json", log_entry: log_entry)
  end
end
