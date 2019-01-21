<p align="center"><img src="assets/logos/128x128.png">
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

- Download the latest [Pharo 32](https://get.pharo.org/) or [64 bits VM](https://get.pharo.org/64/) and follow [installation instructions](docs/Installation.md)
- Explore the [documentation](docs/)

## Installation

To load the project in a Pharo image, or declare it as a dependency of your own project follow this [instructions](docs/Installation.md).


## Acknowledgments

Pharo2VA was influenced by a subset of the [Pharo2VW](https://github.com/ObjectProfile/Pharo2VW) project. There are parts which we even copied and adapted them like the AST literal Array converter . Other parts, we took them as inspiration.


## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
