import {Socket} from "phoenix"
import $ from "jquery"

$(() => {
  let logEntriesTable = $('#log-entries tbody')

  function renderEntries(entries) {
    entries.forEach((entry) => {
      logEntriesTable.append(renderEntry(entry))
    })
  }

  function prependNewEntry(entry) {
    logEntriesTable.prepend(renderEntry(entry))
  }

  function renderEntry(entry) {
    return $(
      `<tr>
        <td>${entry.actor_type}:${entry.actor_id}</td>
        <td>${entry.resource_type}:${entry.resource_id}</td>
        <td>${entry.action}</td>
        <td>${entry.created_at}</td>
      </tr>`
    )
  }

  let socket = new Socket("/socket", {params: {token: window.userToken}})
  socket.connect()

  let channel = socket.channel("log_tail", {})
  channel.join()
    .receive("ok", resp => {
      console.log("Joined successfully")
      renderEntries(resp)
    })
    .receive("error", resp => {
      console.log("Unable to join", resp)
    })

  channel.on("new_entry", entry => {
    console.log("got new entry");
    prependNewEntry(entry)
  })
})

