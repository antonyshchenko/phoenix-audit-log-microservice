# BusinessAuditLog

This is a simple microservice developed to complement my talk about [Phoenix Framework](http://www.phoenixframework.org/). The main purpose of this microservice is storing audit log messages about business relevant events happening in an imaginary distributed system.

`Audit Log Entry` consists of the following fields:
  * `actor_id` - id of an actor that has performed an action
  * `actor_type` - type of the actor: e.g "user", "system"
  * `action` - the action performed
  * `resource_id` - id of resource on which the action was performed
  * `resource_type` - type of resource
  * `created_at` - timestamp

`Audit Log Entry` creation happens as an async reaction to a message published to [AWS SQS](https://aws.amazon.com/sqs/) queue.

## Features

  * it listens to messages from [AWS SQS](https://aws.amazon.com/sqs/) queue
  * it stores an audit log entry into database
  * it provides API to fetch audit log entries
  * it has a web UI to display audit log entries
  * it has a web UI to tail audit log (new entries are broadcaset from server via websockets)

## Running locally

To start your Phoenix server:

  * Start a Docker container with a database: `docker-compose up -d`
  * Install dependencies with `mix deps.get`
  * Create, migrate and populate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `QUEUE_NAME=<your AWS account>/<queue name> mix phx.server mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and see list of audit log entries.

## Publishing new audit log entry

Execute this command in your terminal:

```
aws sqs send-message --queue-url https://eu-west-1.amazonaws.com/<your AWS account>/<queue name> --message-body '{ "event_type": "CREATE_BUSINESS_AUDIT_LOG_ENTRY", "created_at": "2017-03-14T11:17:00Z", "payload": { "actor_id": "2", "actor_type": "user", "action": "Got excited about Elixir", "resource_type": "user", "resource_id": "2" } }'
```

## API

There is only one API endpoint:

`/api/entries/:resource_type/:resource_id`

It returns a paginated list of audit log entries for given resource in JSON format.

Here is usage example:

[`http://localhost:4000/api/entries/user/2?page_size=5&page=1`](http://localhost:4000/api/entries/user/2?page_size=5&page=1)


## Web UI

  * Open [`http://localhost:4000`](http://localhost:4000) to see a paginated list of audit log entries.

  * Open [`http://localhost:4000/tail`](http://localhost:4000/tail) to tail the log. Try to publish some messages to the queue and see how they are delivered to your browser via Websocket connection.
