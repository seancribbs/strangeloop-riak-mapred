!SLIDE center section
# What is Riak?

!SLIDE bullets incremental
# Riak is...

* a scalable, 
* highly-available, 
* networked 
* key/value store.

!SLIDE center

![Riak logo](riak_logo_animated1.gif)

!SLIDE bullets incremental
# Riak Data Model

* Riak stores values against keys.
* Encode your data how you like it.
* Keys are grouped into buckets.

!SLIDE bullets incremental
# Basic Operations

* `GET /riak/bucket/key`
* `PUT /riak/bucket/key`
* `DELETE /riak/bucket/key`
* HTTP or Protocol Buffers

!SLIDE bullets incremental
# Riak stores <br />  metadata with keys.

* `Content-Type`
* `Last-Modified`
* `Link`
* `X-Riak-Meta-*`

!SLIDE bullets incremental

# Two ways to query Riak

* Link traversal ("walking")
* MapReduce
