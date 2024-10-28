# README

The application can receive GraphQL requests to store stock quotes (consisting of a ticker, timestamp and price) in a database.

Given the task's slight ambiguity, I made a few assumptions:
* Integrity checks on the input quotes that seem sensible (1-4 alphabet characters for the ticker, positive integer price).
* Behavior when a quote with and already existing ticker and timestamp pair is sent - the existing quote gets modified in this case.
* It felt weird to not expose any queries to the data, so I made two querying functions. One to get all quotes for a given ticker, and another to get the single most recent quote for a ticker (based on the timestamp).

Some things that might need improving:
* The integrity checks should probably happen on the model level instead of during the processing of the requests.
* Could probably work a bit cleaner with git, but the naming guide was followed to the best of my ability. I messed up the "deployment" a little.
---
The database schema is very simple, and by its simple nature, is normalized:

![The incredibly complex db schema](https://github.com/Igno-C/RoRTask/blob/master/db.png?raw=true)

The GraphQL API is automatically documented by GraphiQL.
