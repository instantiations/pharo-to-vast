# Installation

## Basic Installation

You can load **Pharo2VA** evaluating:
```smalltalk
Metacello new
	baseline: 'Pharo2VA';
	repository: 'github://vasmalltalk/pharo2va:master/source';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **Pharo2VA** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'Pharo2VA'
			with: [ spec
				repository: 'github://vasmalltalk/pharo2va:v{XX}/source';
				loads: #('Deployment') ];
		import: 'Pharo2VA'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('Pharo2VA') ] ]
```
