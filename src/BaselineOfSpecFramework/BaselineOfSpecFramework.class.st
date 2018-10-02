Class {
	#name : #BaselineOfSpecFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpecFramework
}

{ #category : #baseline }
BaselineOfSpecFramework >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec package: 'Spec-Core'.
			spec package: 'Spec-Inspector'.
			spec package: 'Spec-Layout'.
			spec package: 'Spec-MorphicAdapters'.
			spec package: 'Spec-PolyWidgets'.
			spec package: 'Spec-Tools'.
			spec package: 'Spec-Tests'.
			spec package: 'Spec-StubAdapter' ]
]
