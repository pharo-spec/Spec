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
			package: 'Spec-Core';
			package: 'Spec-Inspector';
			package: 'Spec-Layout';
			package: 'Spec-MorphicAdapters';
			package: 'Spec-PolyWidgets';
			package: 'Spec-Tools';
			package: 'Spec-StubAdapter';
			package: 'Spec-Tests' ]
]
