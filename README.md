## Name 

parse.json

## Synopsis 

<!-- TODO: -->


## Download

Download the whole repository

```sh
git clone https://github.com/moledoc/parse.json.git
```

or download the repository/just the tar.xz file from the repository.

## Dependecies

This package uses the following additional packages: **data.table**.

## Overview

<!-- TODO: -->

## Notes

* When writing out list as json, any logical (true/false) values are written out as strings. When using this package to read in that json file, then the logical values are read in as logical. However, when the file in with eg Python, the logical values are read in as strings.
* Currently in write.json, if list/data.frame/data.table contains a factor value, then all values in the json are strings.

## Issues

<!-- TODO: -->

## TODO

<!-- TODO: -->

## Author

Written by
Meelis Utt
