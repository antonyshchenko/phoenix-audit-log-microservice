defmodule BusinessAuditLog.AuditLog do
  import Ecto.{Query, Changeset}, warn: false
  alias BusinessAuditLog.Repo
  alias BusinessAuditLog.AuditLog.LogEntry
  alias BusinessAuditLog.Web.TailChannel
  require Logger

  def list_entries(pagination_params) do
    query = from log_entry in LogEntry,
      order_by: [desc: log_entry.inserted_at]

    Repo.paginate(query, pagination_params)
  end

  def list_entries_by_resource(resource_type, resource_id, pagination_params) do
    query = from log_entry in LogEntry,
      where:
        log_entry.resource_type == ^resource_type and
        log_entry.resource_id == ^resource_id,
      order_by: [desc: log_entry.inserted_at]

    Repo.paginate(query, pagination_params)
  end

  def create_log_entry(attrs \\ %{}) do
    with {:ok, log_entry} <- %LogEntry{}
                              |> log_entry_changeset(attrs)
                              |> Repo.insert(),
         {:ok, log_entry} <- TailChannel.broadcast_new_entry(log_entry)
    do
      {:ok, log_entry}
    else
      error -> error
    end
  end

  defp log_entry_changeset(%LogEntry{} = log_entry, attrs) do
    log_entry
    |> cast(attrs, [:actor_id, :actor_type, :action, :resource_id, :resource_type])
    |> validate_required([:actor_id, :actor_type, :action, :resource_id, :resource_type])
  end
end
