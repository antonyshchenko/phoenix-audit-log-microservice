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
  }
] |> Enum.each(fn attrs ->
  BusinessAuditLog.Repo.insert!(Map.merge(%BusinessAuditLog.AuditLog.LogEntry{}, attrs))
end)
