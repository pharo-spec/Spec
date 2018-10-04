Class {
	#name : #BaselineOfSpec,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpec
}

{ #category : #baseline }
BaselineOfSpec >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec 
			package: 'Spec-Core' with: [ spec requires: #('Spec-Layout') ];
			package: 'Spec-Inspector'with: [ spec requires: #('Spec-PolyWidgets') ];
			package: 'Spec-Layout';
			package: 'Spec-MorphicAdapters' with: [ spec requires: #('Spec-Core') ];
			package: 'Spec-PolyWidgets' with: [ spec requires: #('Spec-Core') ];
			package: 'Spec-Tools' with: [ spec requires: #('Spec-PolyWidgets') ];
			package: 'Spec-StubAdapter' with: [ spec requires: #('Spec-Core') ];
			package: 'Spec-Examples' with: [ spec requires: #('Spec-Tools' 'Spec-Inspector') ];
			package: 'Spec-Tests' with: [ spec requires: #('Spec-PolyWidgets' 'Spec-Examples') ] ]
]
