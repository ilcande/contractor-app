# README
## Requierements
Create two simple Rails applications. Use events, carried over a message broker (eg. RabbitMQ, Kafka, Amazon SQS, etc.) for inter-app communication. It's OK to use libraries, whether it's just a client (eg. bunny) or a full-on message processing system (hutch, karafka, etc).

Each application needs to have its own, separate database.

* Contractor app: a simple application for payment requests where a contractor can request a payment from their manager. A payment request consists of amount, currency, and text description. The contractor should be able to see all of their payment requests, whether they're pending, accepted, or rejected.

* Manager app: a simple application that displays all payment requests submitted by the contractor. The manager can only accept or reject the payment request. The acceptance/rejection of payment request should be handled by the manager app publishing an event and the contractor app processing the event to update the status for the contractor.

## Objective
I have this solution to do this:

*  Use message queue (Advanced Message Queuing Protocol)
This is the solution I choose. Basically AMQP allow that a producer (our Contractor) notify our consumer (Manager) that a new payment request has been created, in a real time. Once it's created it will push this data into a dedicated queue that will be received by the consumer. Efficient, timely and single responsability compliant.

* In this app I configure the producer.

## Configuration

Main goal is to push a message in a queue when we create a new payment request. I’m going to work with `RabbitMQ` and the `Bunny` gem.

First I have to install RabbitMQ on my machine
```
brew install rabbitmq
```

then run
```
/usr/local/opt/rabbitmq/sbin/rabbitmq-server
```

and go to the admin interface http://localhost:15672/ . Password and username are « guest » .

At this point, I add the bunny gem to Gemfile

```
gem 'bunny'
```

and I instantiate a Bunny instance to start a connection, then I create a channel to fanout a queue name to this very channel.

As I want to notify the Manager each time that a payment request is created I call the publish in a create callback.

With the RabbitMQ server running in one terminal (`/usr/local/opt/rabbitmq/sbin/rabbitmq-server`) open a rails console and create a payment request, browse to http://localhost:15672/ and click ont the Exchange tab. You should see an Exchange named `« display.payment_request »`.
