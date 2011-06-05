!SLIDE section
# MapReduce in Riak

!SLIDE bullets incremental
# Riak MapReduce is NOT...

* for batch-processing (yet)
* for building indexes
* for crunching your entire dataset
* limited to one of each function

!SLIDE bullets incremental
# Riak MapReduce IS...

* for low-latency jobs/queries
* for limited, known inputs
* any sequence of Map and Reduce functions

!SLIDE bullets incremental
# Riak MapReduce Features

* JavaScript or Erlang funs
* "Link" phases
* Key-Filters
* Input generators (incl. Search)
* Key-specific data
* Phase-specific data

!SLIDE bullets incremental
# Riak MapReduce Quirks

* Values are opaque
* Map phases take input lists
* Erlang > JavaScript
* Built-ins vs. Source
* Always re-reduce

!SLIDE
# A Simple Query

    POST /mapred
    Content-Type: application/json

&nbsp;
    @@@ javascript

    {
      "inputs":[["people","seancribbs"],
                ["people","roidrage"]],
      "query":[{"map":{
                  "name":"Riak.mapValuesJson",
                  "language":"javascript",
                  "keep":true
               }}]
    }

!SLIDE simple-query-results
# Results
<script type="text/javascript">
(function($){
  $('.simple-query-results').bind('showoff:show',function(){
    var $code = $(this).find('code');
    var job = {
      "inputs":[["people","seancribbs"],
                ["people","roidrage"]],
      "query":[{"map":{
                  "name":"Riak.mapValuesJson",
                  "language":"javascript",
                  "keep":true
               }}]
    };
    /* $.ajax({
      url: '/mapred',
      type: 'POST',
      data: JSON.stringify(job),
      success: function(req){
        $code.text(JSON.stringify(JSON.parse(req.responseText), null,"  "));
        sh_highlightElement($code.parent(), sh_languages['javascript']);
      }
    }); */
  });
})(jQuery);
</script>

    @@@ javascript
