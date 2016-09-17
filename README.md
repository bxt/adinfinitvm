AD·INFINITVM·ATQVE·PLVS·VLTRA
=============================

*To infinity and beyond*

The game **adinfinitvm** is an easy and never ending puzzle game. You try to
connect ropes to a loop without end by rotating. An alternate game mode
is inspired by MacMahon squares and reveals the nature of this game: a two-color
edge-matching puzzle without displacing pieces.

[Go here to play adinfinitvm](http://bxt.github.io/adinfinitvm/).

[Go here to read my blog post about the game (german)](http://bernhardhaeussner.de/blog/134_Ein_sch%C3%B6nes_Online-Spiel_names_adinfinitvm).

Developing
----------

The game is written in CoffeScript without any additional libraries.

To compile the CoffeScript files in `src/` to Javascript, first install:

    npm install -g watchify
    npm install coffeeify minifyify

Then run:

    watchify \
      src/main.coffee \
      -t coffeeify --extension=".coffee" \
      -d -p [minifyify --map script.min.js.map --output script.min.js.map] \
      -v -o script.min.js

This will continuously watch the files for changes and recompile.

Testing
-------

To test install:

    npm install -g mocha
    npm install chai

Then run:

    mocha -w --compilers coffee:coffee-script/register

Debugger
--------

First install the awesome [`node-inspector`](https://github.com/node-inspector/node-inspector):

    npm install -g node-inspector

Put the keyword `debugger` somewhere in your code. Then run:

    node-debug _mocha --compilers coffee:coffee-script/register

Et voila! You stop at a breakpoint where you put your `debugger` keyword.
