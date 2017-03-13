defmodule BusinessAuditLog.AuditLog do
  @moduledoc """
  The boundary for the AuditLog system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias BusinessAuditLog.Repo

  alias BusinessAuditLog.AuditLog.LogEntry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%LogEntry{}, ...]

  """
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

  @doc """
  Creates a log_entry.

  ## Examples

      iex> create_log_entry(log_entry, %{field: value})
      {:ok, %LogEntry{}}

      iex> create_log_entry(log_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log_entry(attrs \\ %{}) do
    %LogEntry{}
    |> log_entry_changeset(attrs)
    |> Repo.insert()
  end

  defp log_entry_changeset(%LogEntry{} = log_entry, attrs) do
    log_entry
    |> cast(attrs, [:actor_id, :actor_type, :action, :resource_id, :resource_type])
    |> validate_required([:actor_id, :actor_type, :action, :resource_id, :resource_type])
  end
end
