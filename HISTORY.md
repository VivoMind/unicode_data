VivoMind Prolog Unicode Resources
=================================

February 7, 2017
----------------

The predicate `unicode_category/2` is faster when checking a code point
for a specific category. When generating code point - category pairs, the
code points are now generated in increasing order.

June 20, 2013
-------------
Third public release featuring a faster implementation of the
`unicode_alphabetic/1` predicate (moved from the `unicode_alphabetic.pl`
file to the new `unicode_range_alphabetic.pl` file).

June 13, 2013
-------------
Second public release featuring a faster implementation of the
`unicode_script/2` predicate (moved from the `unicode_scripts.pl`
file to the new `unicode_range_scripts.pl` file).

April 25, 2013
--------------
First public release.
