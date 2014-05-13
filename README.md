# ActiveRecord (lite): 

ActiceRecord (lite) is a baseline version of Rail's ActiveRecord. While, of course, not nearly as robust as the real-deal. This version employs Ruby's powerful Meta-programming potention to create many of ActiveRecords methods, including: 

* ::all
* ::attr_accessor
* belongs_to
* ::find
* has_many
* has_many_through
* #insert
* #initialize (creates an ActiveRecord object from the given parameters)
* #save
* #update
* ::where

This adventure into metaprogramming also contains RSpect tests. 