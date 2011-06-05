!SLIDE section
# From SQL to MapReduce

!SLIDE
# SELECT \<fields\>

!SLIDE
# SELECT \<fields\>
## **Map** (extract/transform)

    @@@ javascript
    function(object, kd, arg){
      var data = Riak.mapValuesJson(object)[0];    
      var result = {};
      arg.forEach(function(field){
        result[field] = data[field];
      });
      return [result];
    }

!SLIDE
# WHERE \<conditions\>

!SLIDE bullets incremental
# WHERE \<conditions\>
## **Map** (filter)

    @@@ javascript
    function(object){
      var data = Riak.mapValuesJson(object)[0];
      if(data.year == 2011)
        return [data];
      else
        return [];
    }

    Riak.mapByFields, {"year":2011}
    
!SLIDE
# WHERE \<conditions\>
## **Key-filters**

    @@@ javascript
    "inputs":{
       "bucket":"logs",
       "key_filters":[
         ["tokenize", "-", 1]
         ["string_to_int"],
         ["greater_than", 2010]]
    }

!SLIDE
# WHERE \<conditions\>
## **Riak Search hook**

    @@@ javascript
    "inputs":{
      "module":"riak_search",
      "function":"mapred_search",
      "arg":["logs", "year:2011"]
    }

!SLIDE
# JOIN

!SLIDE
# JOIN
## **Map or Link, Map** (traverse)

    @@@ javascript
    
    function(object){
      // Extract some data from the object
      // Set bucket, key, keyData vars
      return [[bucket, key, keyData]];
    }
    
    {"link":{"tag":"parent"}}


!SLIDE
# ORDER BY \<fields\>

!SLIDE
# ORDER BY \<fields\>
## **Reduce** (sort)

    @@@ javascript
    function(values, field){
      return values.sort(function(a,b){
        return a[field] > b[field];
      });
    }
    
    Riak.reduceSort

!SLIDE
# LIMIT \<num\>

!SLIDE bullets
# LIMIT \<num\>
## **Second Reduce**

    @@@ javascript
    function(values, length){
      return values.slice(0, length - 1);
    }
    
    Riak.reduceLimit
    
!SLIDE
# GROUP BY \<fields\>

!SLIDE
# GROUP BY \<fields\>
## **Map, Reduce**

    @@@ javascript
    function map(object){
      var data = Riak.mapValuesJson(object)[0];
      var result = {};
      result[data.year] = [data];
      return [result];
    }

!SLIDE
# GROUP BY \<fields\>
## **Map, Reduce**

    @@@ javascript
    function reduce(values){
      return [values.reduce(function(acc, item){
        for(field in item){
          if(acc[field])
            acc[field] += item[field];
          else
            acc[field] = item[field];
          return acc;
        }
      })];
    }

!SLIDE
# COUNT/SUM/MIN/MAX

!SLIDE bullets incremental
# COUNT/SUM/MIN/MAX
## **Map, Reduce**

* Like `GROUP BY`, Map to a value, then Reduce to collate
* `Riak.reduceSum` 
* `Riak.reduceMin` 
* `Riak.reduceMax`
