# Gerald

When we are summarizing a bunch of data, some operations are easy. We
can add, we can count, we can find the maximum. Other operations are harder. For instance, "count
unique values." "Sum this for only valid values." "Combine these
percentages."

There are ways to treat these harder cases like simple sums, if we get
flexible about the meaning of "plus". Flexible, that is, in a very rigid
way.
If you don't believe me, check @avibryant's talk from StrangeLoop:
http://www.infoq.com/presentations/abstract-algebra-analytics

The architecture of a Gerald is:

from a value, transform it (along with needed context) into something that we
can add. For instance, you can't sum averages... until you include the
total count. So, translate the original percentage into something like
[%,#]. These we can add, with a weighted average. We can add those all
day. Then when we're done, we need another transform back into the
output format we want.
```
% -> [%,#]
    +[%,#]
    ------
% <- [%,#]
```
I asked on twitter what this is called, and apparently it's
Gerald.

https://twitter.com/secretGeek/status/497149218868690945

When we have a simple summing activity, like add or count, then we can
compose them into a single operation.
"add the click-counts in these rows" and "count the rows" compose into
a single function from row to row.

"Does it compose?" is the "Will it blend??" of functional programming.
Functional composition means taking two things of the same type and
combining them into one thing of that type. Endlessly onward, so you can
treat many the same way as one.

Geralds do compose, and they can be useful in summarizing data
declaratively. That's the idea behind this project.

Also, I need to demonstrate property-based testing in Ruby.


