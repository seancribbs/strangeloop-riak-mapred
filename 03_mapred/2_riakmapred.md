!SLIDE section
# MapReduce in Riak

!SLIDE bullets incremental
# Riak MapReduce is NOT...

* for batch-processing
* for building views/indexes
* for crunching your entire dataset
* limited to one of each function

!SLIDE bullets incremental
# Riak MapReduce IS...

* for low-latency jobs/queries
* for limited, known inputs
* any sequence of Map and Reduce functions

!SLIDE bullets incremental
# Features

* JavaScript or Erlang funs
* Search, 2I inputs
* "Link" phases
* Key-Filters
* Key-specific data
* Phase-specific data

!SLIDE bullets incremental
# Riak MapReduce Quirks

* Values are opaque
* Map phases take input lists
* Erlang > JavaScript
* Built-ins > Source
* Reduce funs reapplied

!SLIDE bullets incremental
# Hidden Plumbing

* MapReduce in 1.0 runs atop **Riak Pipe**
* General distributed processing framework
* Mostly invisible to clients

!SLIDE
# A Simple Query

    POST /mapred
    Content-Type: application/json

&nbsp;
    @@@ javascript

    {
      "inputs":[["people","seancribbs"],
                ["people","pharkmillups"]],
      "query":[{"map":{
                  "name":"Riak.mapValuesJson",
                  "language":"javascript",
                  "keep":true
               }}]
    }

!SLIDE
# Results

<iframe src="http://localhost:8098/riak/bbuzz/simple-query-results"
width="100%" height="575"></iframe>
