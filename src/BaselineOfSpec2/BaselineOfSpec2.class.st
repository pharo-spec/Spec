Class {
	#name : #BaselineOfSpec2,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpec2
}

{ #category : #baseline }
BaselineOfSpec2 >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		
		self specCore: spec.
		self specCoreCode: spec.
	
		spec
			"Core"
			package: 'Spec2-Adapters-Morphic' with: [ spec requires: #('SpecCore') ];
			package: 'Spec2-Code-Morphic' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			package: 'Spec2-Morphic' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			"Tests"
			package: 'Spec2-Morphic-Examples' with: [ spec requires: #('Spec2-Morphic') ];
			package: 'Spec2-Backend-Tests' with: [ spec requires: #('SpecCore' 'Spec2-Adapters-Morphic') ];
			package: 'Spec2-Morphic-Backend-Tests' with: [ spec requires: #('Spec2-Adapters-Morphic' 'Spec2-Backend-Tests') ];
			package: 'Spec2-Adapters-Morphic-Tests' with: [ spec requires: #('Spec2-Backend-Tests') ];
			package: 'Spec2-Morphic-Tests' with: [ spec requires: #('Spec2-Morphic' 'Spec2-Backend-Tests') ];
			package: 'Spec2-Code-Backend-Tests' with: [ spec requires: #('Spec2-Backend-Tests') ];
			"others"
			package: 'Spec2-Help' ].
	
	spec group: 'Core' with: #('SpecCore' 'Spec2-Morphic' 'Spec2-Adapters-Morphic').
	spec group: 'Code' with: #('Core' 'SpecCoreCode' 'Spec2-Code-Morphic').
	spec group: 'CodeTests' with: #('Code' 'Spec2-Code-Backend-Tests').
	spec group: 'Support' with: #('Core' 'Spec2-Morphic-Examples').
	spec group: 'Tests' with: #(
		'SpecCore'
		'Core' 
		'Spec2-Morphic-Tests' 
		'Spec2-Morphic-Backend-Tests' 
		'Spec2-Backend-Tests'
		'Spec2-Adapters-Morphic-Tests').
	spec group: 'Base' with: #(
		'SpecCore'
		'Core'
		'Support').

	spec group: 'default' with: #('Base' 'Tests' 'Code' 'CodeTests').
]

{ #category : #'external projects' }
BaselineOfSpec2 >> defaultRepositoryURL [
		
	^ self class environment 
		at: #BaselineOfPharo
		ifPresent: [ :aClass | aClass specRepository ]
		ifAbsent: [ 'github://pharo-spec/Spec' ]
]

{ #category : #'external projects' }
BaselineOfSpec2 >> packageRepository [

	" Tries to determine a repository from which the baseline is being loaded. Useful for 
	refering other baselines in the same repository. "
	
	^ (self class package mcWorkingCopy repositoryGroup repositories 
		reject: [:each | each = MCCacheRepository uniqueInstance]) 
		ifNotEmpty: [ :repositories | 
				repositories 
					detect: [ :each | each description beginsWith: 'tonel://' ]
					ifNone: [ repositories anyOne ] ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
BaselineOfSpec2 >> project [
	"Atomic loading is needed for Spec because we are moving classes of package and it breaks their subclasses. 
	
	Here is an explanation I wrote on Discord:
	
«The problem with Obsolete classes is that classes with subclasses were moved from Spec-Core to Spec-Deprecated80. 

When updating Spec it will first load Spec-Core. This will delete the class and its subclasses will be migrated to an obsolete superclass. 
Then Spec-Deprecated80 is loaded but it does not migrate the subclasses of the obsolete class to it. (Apparently there is an intern working on that Pablo told me).»

We need to use atomic loading only during update of existing Spec upgrade"

	^self class environment at: #SpPresenter 
		ifPresent: [
			super project
				loadType: #atomic;
				yourself ] 
		ifAbsent: [ 		
			super project
				loadType: #linear;
				yourself  ]

	 
]

{ #category : #'external projects' }
BaselineOfSpec2 >> specCore: spec [

	spec baseline: 'SpecCore' with: [ 
		spec 
			repository: 'github://pavel-krivanek/Spec:unsubscribeAdapters';
			loads: #('Base' 'Tests') ]
]

{ #category : #'external projects' }
BaselineOfSpec2 >> specCoreCode: spec [

	spec baseline: 'SpecCoreCode' with: [ 
		spec 
			repository: 'github://pavel-krivanek/Spec:unsubscribeAdapters';
			className: 'BaselineOfSpecCore';
			loads: #('Code' 'CodeTests') ]
]
