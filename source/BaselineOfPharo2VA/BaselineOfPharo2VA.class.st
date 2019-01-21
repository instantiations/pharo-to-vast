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
        do: [ spec package: #'Pharo2VA-Core'.
            spec
                group: 'default' with: #('core');
                group: 'core' with: #('Pharo2VA-Core') ]
]
