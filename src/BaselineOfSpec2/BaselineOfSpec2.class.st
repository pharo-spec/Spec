Class {
	#name : #BaselineOfSpec2,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpec2
}

{ #category : #baseline }
BaselineOfSpec2 >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		self commander2: spec.
		self complishon: spec.
		
		spec
			package: 'Spec2-ObservableSlot';
			package: 'Spec2-Core' with: [ 
				spec requires: #(
					'Spec2-ObservableSlot'
					'Spec2-Layout' 
					'Spec2-Transmission' 
					'Spec2-Commands') ];
			package: 'Spec2-CommandLine' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-Commands' with: [ spec requires: #('Commander2') ];
			package: 'Spec2-Layout' with: [ spec requires: #('Spec2-ObservableSlot') ];
			package: 'Spec2-Transmission';
			package: 'Spec2-Adapters-Morphic' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-CodePresenter' with: [ spec requires: #('Spec2-Adapters-Morphic' 'Complishon') ];
			package: 'Spec2-CodePresenter-Tests' with: [ spec requires: #('Spec2-CodePresenter') ];
			package: 'Spec2-Adapters-Stub' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-Interactions' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-Commander2' with: [ 
				spec requires: #(
					'Spec2-Core' 
					'Spec2-Interactions' 
					'Commander2') ];
			package: 'Spec2-Commander2-Tests' with: [ spec requires: #('Spec2-Commander2') ];
			package: 'Spec2-Commander2-ContactBook' with: [ spec requires: #('Spec2-Commander2') ];
			package: 'Spec2-Commander2-ContactBook-Extensions' with: [ spec requires: #('Spec2-Commander2-ContactBook') ];
			package: 'Spec2-Tests' with: [ spec requires: #('Spec2-Examples') ];
			package: 'Spec2-Morphic-Backend-Tests' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			package: 'Spec2-Backend-Tests' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			package: 'Spec2-Adapters-Morphic-Tests' with: [ spec requires: #('Spec2-Tests' 'Spec2-Backend-Tests') ];
			package: 'Spec2-Tools' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-Tools-Tests' with: [ spec requires: #('Spec2-Tests' 'Spec2-Tools') ];
			package: 'Spec2-MorphicPresenters' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			package: 'Spec2-MorphicPresenters-Tests' with: [ spec requires: #('Spec2-MorphicPresenters') ];
			package: 'Spec2-Examples' with: [ spec requires: #('Spec2-MorphicPresenters') ].
			"This will extend the help tool, which in boostrap will be loaded a lot later."
			"package: 'Spec2-Help';"		
		 ].
	
	spec group: 'Support' with: #('Spec2-ObservableSlot' ).
	spec group: 'Core' with: #('Support' 'Spec2-Layout' 'Spec2-Transmission'  'Spec2-Commands' 'Spec2-Core' 'Spec2-CommandLine' 'Spec2-Adapters-Stub' 'Spec2-Interactions' 'Spec2-Commander2' 'Spec2-Commander2-ContactBook' 'Spec2-Commander2-ContactBook-Extensions' ).
	spec group: 'Tests' with: #( 'Core' 'Spec2-Tests' 'Spec2-Commander2-Tests' ).
	spec group: 'MorphicSupport' with: #( 'Tests' 'Spec2-CodePresenter' 'Spec2-Adapters-Morphic' 'Spec2-MorphicPresenters' 'Spec2-Examples'  'Spec2-Tools' ).
	spec group: 'MorphicSupportTests' with: #( 'MorphicSupport' 'Spec2-CodePresenter-Tests'  'Spec2-Tools-Tests' 'Spec2-Adapters-Morphic-Tests' 'Spec2-MorphicPresenters-Tests' 'Spec2-Morphic-Backend-Tests' 'Spec2-Backend-Tests' ).
	spec group: 'default' with: #( 'MorphicSupportTests' ).

	spec for: #'pharo8.x' do: [
		spec
			package: 'Spec2-Tools' with: [ spec requires: #('Spec2-Core') ];
			package: 'Spec2-Tools-Tests' with: [ spec requires: #('Spec2-Tests' 'Spec2-Tools') ];
			package: 'Spec2-Examples' with: [ spec requires: #('Spec2-Tools') ] ].
		
	
]

{ #category : #dependencies }
BaselineOfSpec2 >> commander2: spec [
	spec
		baseline: 'Commander2'
		with: [ spec repository: 'github://pharo-spec/Commander2:v2.1.x/src'; loads: #('core' 'ui') ]
]

{ #category : #dependencies }
BaselineOfSpec2 >> complishon: spec [
	
	spec
		baseline: 'Complishon'
		with: [ spec repository: 'github://guillep/complishon' ]
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
