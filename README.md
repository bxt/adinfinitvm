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

To compile the CoffeScript files in `src/` to Javascript, first install coffeebar:

    npm install -g coffeebar

Then run:

    coffeebar -wmo script.min.js \
      src/Square.coffee \
      src/SquareDesigns.coffee \
      src/TriangularSquareDesigns.coffee \
      src/PathySquareDesigns.coffee \
      src/Button.coffee \
      src/SquareView.coffee \
      src/Grid.coffee \
      src/GridView.coffee \
      src/Levels.coffee \
      src/Instructions.coffee \
      src/Header.coffee \
      src/Main.coffee

This will continuously watch the files for changes and recompile.
