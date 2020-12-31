## Name 

parse.json

## Synopsis 

This is a package to read json objects into R list or write a R list into json object. This package is written using only R.

## Dependecies

This package uses the following additional packages/functions: **data.table**; **utils** function download.file().

## Setup

There are multiple ways to set up the package:
  
  * building the package from source code.
  * building package from source package.

Obtaining the source code:

  * Download the whole repository

```sh
git clone https://github.com/moledoc/parse.json.git
```

  * Download the repository as a zip file and unpacking it.
  
Obtaining the source package:
  
  * The source package is added to repository, so one can use previous methods to acquire source package.
  * Download only package source file. Package source file is named as parse.json_<version>.tar.gz and is located at the root directory of the repository.
  
Building from source code:
  
  * In RStudio import the project and run 'Install and Restart' under Build.
  * In the terminal/commandline run the following command in the directory, where parse.json/ directory exists:
  
```sh
R CMD INSTALL --no-multiarch --with-keep.source parse.json
```

Building from source package:

  * In RStudio in Packages tab click Install and select 'Install from' to be 'Package archive', locate the tar.gz package and leave 'Install dependencies' ticked.
  * In R console run the following command:

```r
install.packages("path/to/tar.gz",repos=NULL,type="source")
```

## Notes/Issues/TODOs

* Notes: currently none
* Issues: currently none
* TODO: currently none

## License

This package is available under MIT license.

## Author

Written by
Meelis Utt
