# Haskell Your Own Adventure

[![Build Status](https://travis-ci.org/webbiscuit/haskell-adventure.svg?branch=master)](https://travis-ci.org/webbiscuit/haskell-adventure)

## What is it?

A functional project that can parse, play and analyse gamebooks from text.

This early version parses basic text files into section and choice objects and can output in a few different ways.

## Pre-reqs

Stack

    stack setup
    stack install hlint

## Building

    stack build

## Debugging

    stack ghci
    parseTextIntoBook "1\nAll of these passages look alike. Turn to 1"

## Running tests

    stack test

To watch files and continuously run tests:

    stack test --file-watch --fast

## Linting

    hlint src

## Documentation

    stack haddock --no-haddock-deps

## Usage

    stack run -- --file app/books/fridge.txt

or

    stack run -- --stdin < app/books/fridge.txt

or (when built)

    haskelladventure.exe --stdin < path-to-your-gamebook

## Outputs

There are a few formats currently supported:

debug (haskell debugging)
json (parsed as json objects)
dot (graphviz dot format)

    stack run -- --output json --file app/books/fridge.txt

## Sample Books

### Fridge

A horror scenario where you wake up trapped inside a fridge.
