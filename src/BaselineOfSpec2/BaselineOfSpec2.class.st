Class {
	#name : #BaselineOfSpec2,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpec2
}

{ #category : #baseline }
BaselineOfSpec2 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self parametrizedTests: spec.

			"Packages"
			spec
				package: 'Spec2-Core'
					with: [ spec requires: #('Spec2-Layout' 'Spec2-Transmission') ];
				package: 'Spec2-CommandLine'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-Help';
				package: 'Spec2-Commands'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-Deprecated'
					with: [ spec
						requires: #('Spec2-Tests' 'Spec2-PolyWidgets-Tests' 'Spec2-Adapters-Morphic') ];
				package: 'Spec2-Inspector'
					with: [ spec requires: #('Spec2-PolyWidgets') ];
				package: 'Spec2-Layout';
				package: 'Spec2-Transmission';
				package: 'Spec2-Adapters-Morphic'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-PolyWidgets'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-Adapters-Stub'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-Examples'
					with: [ spec requires: #('Spec2-Inspector') ];
				package: 'Spec2-Interactions'
					with: [ spec requires: #('Spec2-Core') ];
				package: 'Spec2-Commander2'
					with: [ spec requires: #('Spec2-Core' 'Spec2-Interactions') ];
				package: 'Spec2-Commander2-Compatibility'
					with: [ spec requires: #('Spec2-Commander2') ];
				package: 'Spec2-Commander2-Tests'
					with: [ spec requires: #('Spec2-Commander2') ];
				package: 'Spec2-Commander2-ContactBook'
					with: [ spec requires: #('Spec2-Commander2') ];
				package: 'Spec2-Commander2-ContactBook-Extensions'
					with: [ spec requires: #('Spec2-Commander2-ContactBook') ];
				package: 'Spec2-Tests'
					with: [ spec requires: #('Spec2-Examples') ];
				package: 'Spec2-PolyWidgets-Tests'
					with: [ spec requires: #('Spec2-Tests' 'Spec2-PolyWidgets') ];
				package: 'Spec2-Morphic-Backend-Tests'
					with: [ spec requires: #('Spec2-Adapters-Morphic' 'ParametrizedTests') ];
				package: 'Spec2-Backend-Tests'
					with: [ spec requires: #('Spec2-Adapters-Morphic' 'ParametrizedTests') ];
				package: 'Spec2-Compatibility-Tests'
					with: [ spec requires: #('Spec2-Morphic-Backend-Tests' 'Spec2-Deprecated') ]].
				
	spec
		for: #'pharo7.x'
		do: [ self commander2: spec.
			spec
				package: 'Spec2-Pharo7To8Compatibility';
				package: 'Spec2-Commander2'
					with: [ spec requires: #('Commander2') ] ].
	spec
		for: #'pharo8.x'
		do: [ spec
				package: 'Spec2-Tools'
					with: [ spec requires: #('Spec2-PolyWidgets') ];
				package: 'Spec2-Examples'
					with: [ spec requires: #('Spec2-Tools') ];
				package: 'Spec2-Deprecated-Tools'
					with: [ spec requires: #('Spec2-Deprecated' 'Spec2-Tools') ] ]
]

{ #category : #dependencies }
BaselineOfSpec2 >> commander2: spec [
	spec
		baseline: 'Commander2'
		with: [ spec repository: 'github://pharo-spec/Commander2/src' ]
]

{ #category : #dependencies }
BaselineOfSpec2 >> parametrizedTests: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #accessing }
BaselineOfSpec2 >> project [
	"Atomic loading is needed for Spec because we are moving classes of package and it breaks their subclasses. 
	
	Here is an explanation I wrote on Discord:
	
«The problem with Obsolete classes is that classes with subclasses were moved from Spec-Core to Spec-Deprecated80. 

When updating Spec it will first load Spec-Core. This will delete the class and its subclasses will be migrated to an obsolete superclass. 
Then Spec-Deprecated80 is loaded but it does not migrate the subclasses of the obsolete class to it. (Apparently there is an intern working on that Pablo told me).»"

	^ super project
		loadType: #atomic;
		yourself
]
