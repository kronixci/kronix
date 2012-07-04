kronix
======

Quick-and-dirty CI server

It's purpose is only serve one rails app and run all tests when a push
to github happens.

testing
====

 * You need some gems for now ( rake, rspec )
 * Go to `test/cloned_projects` and clone `walky` project from my github
   twice, the second one rename to walky_fails and write a fails test
   and commit.
 * Now you be able to execute testing for kronix ( I think )


TODO
===
 * We need let the testing process more smooth.
 * And of course, implement all CI process :)
