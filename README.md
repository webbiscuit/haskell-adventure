# Haskell Your Own Adventure

[![Build Status](https://travis-ci.org/webbiscuit/haskell-adventure.svg?branch=master)](https://travis-ci.org/webbiscuit/haskell-adventure)

## What is it?

A functional project that can parse, play and analyse gamebooks.

This early version parses basic text files into section and choice objects.

## Building

    stack build

## Running

    stack ghci
    main2

To test interactively:

    :load Gamebook

## Usage

    stack run < app/books/fridge.txt

or (when built)

    haskelladventure-exe.exe < path-to-your-gamebook

## Books

### Fridge

A horror scenario where you wake up trapped inside a fridge.
