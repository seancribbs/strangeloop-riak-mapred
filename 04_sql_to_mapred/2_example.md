!SLIDE
# Putting it Together

!SLIDE bullets
# Riddle Me This

* "Of my social-network friends, who are the top 5 who have the most
  friends in common with me?"

!SLIDE bullets incremental
# Make a Strategy

* Get my friends-list
* Fetch each friend's friends-list and find the number in common
* Sort the list by the count
* Limit to the top 5

!SLIDE
# Get my Friends-List
## **Inputs** (to the Map)

    @@@ javascript
    "inputs":[["friends","seancribbs"]]


!SLIDE
# Fetch my Friends' Friends
## **Map**

    @@@ javascript
    function(object){
      var list = Riak.mapValues(object)[0]
          .split("\n").sort();
      var hashList = list.reduce(
        function(r, name){
          r[name] = 1; return r;
        }, {});
      return list.map(function(friend){
        // Fetch friends' friends-list,
        // and forward my list as keyData
        return ["friends", friend, hashList];
      });
    }
    
!SLIDE
# Count Friends in Common
## **Map**

    @@@ javascript
    function(object, myList){
      var list = Riak.mapValues(object)[0]
          .split("\n").sort();
      var count = list.reduce(
        function(counter, name){
          if(myList[name])
            return counter + 1;
          else
            return counter;
        }, 0);
      return [{'name':object.key,
               'count':count}];
    }

!SLIDE
# Sort Descending and Limit
## **Reduce**

    @@@ javascript
    function(values){
      return Riak.filterNotFound(values).sort(
        function(a,b){
          return (a.count > b.count) ? -1 : 1;
        }).slice(0,5);
    }

!SLIDE
# Take this Job and Run It

<iframe
src="http://localhost:8098/riak/bbuzz/sql-to-mapred-example"
width="100%" height="575"></iframe>

