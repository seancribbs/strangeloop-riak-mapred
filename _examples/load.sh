#!/bin/bash

node=localhost:8098

for js in *.js
do
    echo "Uploading $js to /riak/bbuzz/$js"
    curl -X PUT -H "Content-Type: text/javascript" --data-binary @$js http://$node/riak/bbuzz/$js
done

for gif in *.gif
do
    echo "Uploading $gif to /riak/bbuzz/$gif"
    curl -X PUT -H "Content-Type: image/gif" --data-binary @$gif http://$node/riak/bbuzz/$gif
done

for css in *.css
do
    echo "Uploading $css to /riak/bbuzz/$css"
    curl -X PUT -H "Content-Type: text/css" --data-binary @$css http://$node/riak/bbuzz/$css
done

for html in sql-to-mapred-example simple-query-results
do
    echo "Uploading $html to /riak/bbuzz/$html"
    curl -X PUT -H "Content-Type: text/html" --data-binary @$html http://$node/riak/bbuzz/$html
done

for friend in friends/*
do
    echo "Loading $friend"
    curl -X PUT -H "Content-Type: text/plain" --data-binary @$friend http://$node/riak/$friend
done

for person in people/*
do
    echo "Loading $person"
    curl -X PUT -H "Content-Type: application/json" --data-binary @$person http://$node/riak/$person
done
