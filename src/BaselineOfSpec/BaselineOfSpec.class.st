Class {
	#name : #BaselineOfSpec,
	#superclass : #BaselineOf,
	#instVars : [
		'link'
	],
	#category : #BaselineOfSpec
}

{ #category : #baseline }
BaselineOfSpec >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec postLoadDoIt: #recompileAll.

			"Dependencies"
			self parametrizedTests: spec.

			"Packages"
			spec
				package: 'Spec-Core' with: [ spec requires: #('Spec-Layout' 'Spec-Transmission') ];
				package: 'Spec-Commands' with: [ spec requires: #('Spec-Core') ];
				package: 'Spec-Deprecated80' with: [ spec requires: #('Spec-Tests' 'Spec-PolyWidgets-Tests' 'Spec-MorphicAdapters') ];
				package: 'Spec-Inspector' with: [ spec requires: #('Spec-PolyWidgets') ];
				package: 'Spec-Layout';
				package: 'Spec-Transmission';
				package: 'Spec-MorphicAdapters' with: [ spec requires: #('Spec-Core') ];
				package: 'Spec-PolyWidgets' with: [ spec requires: #('Spec-Core') ];
				package: 'Spec-Tools' with: [ spec requires: #('Spec-PolyWidgets') ];
				package: 'Spec-StubAdapter' with: [ spec requires: #('Spec-Core') ];
				package: 'Spec-Examples' with: [ spec requires: #('Spec-Tools' 'Spec-Inspector') ];
				package: 'Spec-Tests' with: [ spec requires: #('Spec-Examples') ];
				package: 'Spec-PolyWidgets-Tests' with: [ spec requires: #('Spec-Tests' 'Spec-PolyWidgets') ];
				package: 'Spec-MorphicBackendTests' with: [ spec requires: #('Spec-MorphicAdapters' 'ParametrizedTests') ];
				package: 'Spec-BackendTests' with: [ spec requires: #('Spec-MorphicAdapters' 'ParametrizedTests') ];
				package: 'Spec-CompatibilityTests' with: [ spec requires: #('Spec-MorphicBackendTests' 'Spec-Deprecated80') ]  ].
	spec for: #'pharo7.x' do: [ spec package: 'Spec-Pharo7To8Compatibility' ]
]

{ #category : #dependencies }
BaselineOfSpec >> parametrizedTests: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #accessing }
BaselineOfSpec >> project [
	"Atomic loading is needed for Spec because we are moving classes of package and it breaks their subclasses. 
	
	Here is an explanation I wrote on Discord:
	
«The problem with Obsolete classes is that classes with subclasses were moved from Spec-Core to Spec-Deprecated80. 

When updating Spec it will first load Spec-Core. This will delete the class and its subclasses will be migrated to an obsolete superclass. 
Then Spec-Deprecated80 is loaded but it does not migrate the subclasses of the obsolete class to it. (Apparently there is an intern working on that Pablo told me).»"

	^ super project
		loadType: #atomic;
		yourself
]

{ #category : #public }
BaselineOfSpec >> recompileAll [
	"In Pharo 7 we need to recompile the code of the image to make it work."

	SystemVersion current major = 7 ifFalse: [ ^ self ].

	OpalCompiler recompileAll
]
