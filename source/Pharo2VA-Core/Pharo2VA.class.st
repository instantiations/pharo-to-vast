"
Pharo2VA is a class for easing porting code from Pharo to VA
"
Class {
	#name : #Pharo2VA,
	#superclass : #Object,
	#instVars : [
		'directory',
		'packagesNames',
		'methodsBlacklist',
		'extendedClassesBlackList',
		'classesBlackList'
	],
	#category : #'Pharo2VA-Core'
}

{ #category : #'instance creation' }
Pharo2VA class >> exporter [
	^ self new
]

{ #category : #'public export' }
Pharo2VA >> addToBlacklistAllExtensionsOf: aListOfClasses [
	extendedClassesBlackList := aListOfClasses
]

{ #category : #accessing }
Pharo2VA >> classesBlackList [
	^ classesBlackList
]

{ #category : #'public export' }
Pharo2VA >> classesBlackList: aListOfClasses [
	classesBlackList := aListOfClasses
]

{ #category : #'public export' }
Pharo2VA >> convertCurlyBraces: aMCVersion [
	(aMCVersion snapshot definitions
		select: [ :each | each isMethodDefinition ])
		do: [ :aMethodDef | 
			| ast |
			ast := RBParser parseMethod: aMethodDef source.
			Pharo2VACurlyBracesConvertor new visitNode: ast.
			aMethodDef
				instVarNamed: 'source'
				put: (BIConfigurableFormatter format: ast) ]
]

{ #category : #accessing }
Pharo2VA >> directory [
	^ directory
]

{ #category : #accessing }
Pharo2VA >> directory: aNewDirectory [
	directory := aNewDirectory
]

{ #category : #'public export' }
Pharo2VA >> excludeBlackListClasses: aMCVersion [
	| defs |
	defs := aMCVersion snapshot definitions.
	defs
		removeAllSuchThat: [ :each | 
			(each isMethodDefinition or: [ each isClassDefinition ])
				and: [ (classesBlackList includes: each actualClass classSide)
						or: [ classesBlackList includes: each actualClass instanceSide ] ] ]
]

{ #category : #'public export' }
Pharo2VA >> excludeBlackListExtendedMethods: aMCVersion [
	| defs |
	defs := aMCVersion snapshot definitions.
	defs
		removeAllSuchThat: [ :each | 
			(each isMethodDefinition and: [ each isExtensionMethod ])
				and: [ (extendedClassesBlackList includes: each actualClass classSide)
						or:
							[ extendedClassesBlackList includes: each actualClass instanceSide ] ] ]
]

{ #category : #'public export' }
Pharo2VA >> excludeBlackListMethods: aMCVersion [
	| defs |
	defs := aMCVersion snapshot definitions.
	(defs select: [ :each | each isMethodDefinition ])
		do: [ :aMethodDef | 
			methodsBlacklist
				do: [ :blackMethod | 
					((aMethodDef actualClass = blackMethod methodClass
						and: [ aMethodDef selector = blackMethod selector ])
						and: [ aMethodDef category = blackMethod category ])
						ifTrue: [ defs remove: aMethodDef ] ] ]
]

{ #category : #'public export' }
Pharo2VA >> export [
	| outputDir |
	directory ensureDeleteAll.
	directory ensureCreateDirectory.
	outputDir := directory asFileReference.
	packagesNames
		do:
			[ :aPackageName | self exportPackageNamed: aPackageName on: outputDir ]
]

{ #category : #'public export' }
Pharo2VA >> exportPackageNamed: aPackageName on: aDirectory [
	| mcRepository mcWorkingCopy mcVersion |
	mcRepository := MCDirectoryRepository new directory: aDirectory.
	mcWorkingCopy := (RPackageOrganizer default packageNamed: aPackageName)
		mcWorkingCopy.
	mcVersion := mcWorkingCopy
		newVersionWithName: (mcWorkingCopy uniqueVersionNameIn: mcRepository)
		message: 'empty log message'
		in: mcRepository.
	self excludeBlackListMethods: mcVersion.
	self excludeBlackListExtendedMethods: mcVersion.
	self excludeBlackListClasses: mcVersion.
	self convertCurlyBraces: mcVersion.
	mcRepository storeVersion: mcVersion.
	mcRepository storeDependencies: mcVersion
]

{ #category : #accessing }
Pharo2VA >> extendedClassesBlackList [
	^ extendedClassesBlackList
]

{ #category : #accessing }
Pharo2VA >> filenames [
	^ packagesNames collect: [ :each | directory / each , '.mcz' ]

]

{ #category : #initialization }
Pharo2VA >> initialize [
	super initialize.
	directory := FileSystem disk workingDirectory.
	methodsBlacklist := #().
	extendedClassesBlackList := #().
	classesBlackList := #()
]

{ #category : #accessing }
Pharo2VA >> methodsBlacklist [
	^ methodsBlacklist
]

{ #category : #accessing }
Pharo2VA >> methodsBlacklist: aListOfCompiledMethods [
	methodsBlacklist := aListOfCompiledMethods
]

{ #category : #'public export' }
Pharo2VA >> packageName: aString [
	self packages: {aString}
]

{ #category : #'public export' }
Pharo2VA >> packagesNames: listOfPackageNames [
	packagesNames := listOfPackageNames
]
