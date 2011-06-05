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
      var list = object.values[0].split("\n")
                   .sort();
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
      var list = object.values[0].split("\n")
                   .sort();
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
# Sort the List Descending
# by Count
## **Reduce**

    @@@ javascript
    function(values){
      return values.sort(function(a,b){
        // Use < for descending order
        return a.count < b.count;
      });
    }

!SLIDE
# Limit to the Top 5
## **Reduce**

    @@@ javascript
    {"reduce":{
      "name":"Riak.reduceLimit",
      "arg":5,
      "keep":true
    }}

!SLIDE
# Take this Job and Run It

<!-- insert submission code here -->
