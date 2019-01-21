Class {
	#name : #Pharo2VAExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'rootPath'
	],
	#category : #'Pharo2VA-Tests'
}

{ #category : #initialization }
Pharo2VAExporterTest >> exportedFile [
	^ 'MyPharo2VATest.mcz' asFileReference
]

{ #category : #support }
Pharo2VAExporterTest >> exporter [
	^ Pharo2VA exporter
]

{ #category : #initialization }
Pharo2VAExporterTest >> initialize [
	rootPath := ''
]

{ #category : #initialization }
Pharo2VAExporterTest >> tearDown [
	self exportedFile ensureDelete
]

{ #category : #tests }
Pharo2VAExporterTest >> testBasicExport [
	| inst |
	inst := self exporter.
	self
		assert: inst directory equals: FileSystem disk workingDirectory;
		assert: inst methodsBlacklist equals: #();
		assert: inst extendedClassesBlackList equals: #();
		assert: inst classesBlackList equals: #().
		
]
