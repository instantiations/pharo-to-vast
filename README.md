<p align="center">
 <!-- <img src="assets/logos/128x128.png">  -->
 <h1 align="center">Pharo2VA</h1>
  <p align="center">
    Facilitating code export from Pharo to VA Smalltalk
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    <br>
    <a href="https://github.com/vasmalltalk/pharo2va/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/vasmalltalk/pharo2va/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

[![GitHub release](https://img.shields.io/github/release/vasmalltalk/pharo2va.svg)](https://github.com/vasmalltalk/pharo2va/releases/latest)
[![Build Status](https://travis-ci.com/vasmalltalk/pharo2va.svg?branch=master)](https://travis-ci.com/vasmalltalk/pharo2va)
[![Coverage Status](https://coveralls.io/repos/github/vasmalltalk/pharo2va/badge.svg?branch=master)](https://coveralls.io/github/vasmalltalk/pharo2va?branch=master)

Little tool to ease exporting code from Pharo to VA Smalltalk

This is an exporter from Pharo source code to Instantiations VA Smalltalk. This exporter can reject explicit classes, extension methods, methods, and generates the resulting Monticello files (.mcz) into a user specified direcotry.  

By default, the exporter will also take care of re-write the Pharo's literal Array that use curly brackets with a way that would work in VA Smalltalk.


## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## Quick Start

- Download the latest [Pharo 32](https://get.pharo.org/) or [64 bits VM](https://get.pharo.org/64/) and follow this [instructions](docs/Installation.md).
- Download a ready to use image from the [release page](https://github.com/vasmalltalk/pharo2va/releases/latest)
- Explore the [documentation](docs/)


## Installation

To load the project in a Pharo image, or declare it as a dependency of your own project follow this [instructions](docs/Installation.md).


## Example

Below is an example when porting STON to VA:

```smalltalk
Pharo2VA
	exporter
		directory: FileSystem disk workingDirectory / 'exports';
		packagesNames: {'STON-Core' . 'STON-Tests'};
		methodsBlacklist:
			{(Text class >> #fromSton:).
			(STONWriterTests >> #testMimeType).
			(STONWriteReadTests >> #testFileSystemSupport).
			(STONWriteReadTests >> #testMimeTypes).
			(STONWriteReadTests >> #testTextAndRunArray).
			(STONReaderTests >> #testMimeType).
			(STONReaderTests >> #testWideSymbol).
			(STONReaderTests >> #testClassWithUnderscore).
			(STONReaderTests >> #testURL).
			(STONWriterTests >> #testURL)};
		addToBlacklistAllExtensionsOf:
			{RunArray.
			FileReference.
			SmallDictionary.
			ZnMimeType.
			ZnUrl.
			Path.
			OrderedDictionary};
		classesBlackList: {STONFileReference};
		export
```

Before evaluating above code, be sure to have those packages `'STON-Core'` and `'STON-Tests'` loaded into your image (for the tool it doesn't matter how you load them).

Evaluating that code will end up creating one .mcz file (Monticello file) per exported packaged (`#packagesNames:`), under the specified directory (`#directory:`). As you can see, there are ways to exclude methods (`#methodsBlacklist:`), extension methods from classes (`#addToBlacklistAllExtensionsOf`), and even full classes (`#classesBlackList:`).

## Converting literal arrays

VA Smalltalk do not have the same array notation for `{}` as Pharo has. But do not worry this exporter export this `{'A'}` in this order `(Array new: 1) at: 1 put: 'A'`.

## Importing on VA

To import in VA, you can use the [Monticello Importer](https://www.instantiations.com/docs/91/wwhelp/wwhimpl/js/html/wwhelp.htm#href=sg/stugmi.html) feature.

Right now the tool always exports the packages into .mcz and so you must use Monticello Importer in VA to import. However, as soon as Tonel is supported on VA, this tool would be able to write into Tonel instead of .mcz.


## Acknowledgments

- Pharo2VA was influenced by a subset of the [Pharo2VW](https://github.com/ObjectProfile/Pharo2VW) project. There are parts which we even copied and adapted them like the AST literal Array converter . Other parts, we took them as inspiration.
- Github repository layout was generated with [Ba-St Github-setup project](https://github.com/ba-st/GitHub-setup).
- Thanks [Gabriel Cotelli](https://github.com/gcotelli) for the help on setting up Travis CI and Coveralls integration. 

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
