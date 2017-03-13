# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BusinessAuditLog.Repo.insert!(%BusinessAuditLog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

[
  %{
    actor_type: "user",
    actor_id: "1",
    action: "user disabled",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "1",
    action: "user enabled",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "2",
    action: "user changed email",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "2",
    action: "user logged in",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "2",
    action: "user changed address",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "1",
    action: "user disabled",
    resource_type: "user",
    resource_id: "2"
  },
  %{
    actor_type: "user",
    actor_id: "1",
    action: "user was deleted",
    resource_type: "user",
    resource_id: "2"
  },
] |> Enum.each(fn attrs ->
  %BusinessAuditLog.AuditLog.LogEntry{}
  |> Map.merge(attrs)
  |> BusinessAuditLog.Repo.insert!
end)
