Class {
	#name : #BaselineOfPharo2VA,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharo2VA
}

{ #category : #baselines }
BaselineOfPharo2VA >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Pharo2VA-Core';
				package: 'Pharo2VA-Tests'.
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Pharo2VA-Core');
				group: 'Tests' with: #('Pharo2VA-Tests');
				group: 'Development' with: #('Core' 'Tests') ]
]
