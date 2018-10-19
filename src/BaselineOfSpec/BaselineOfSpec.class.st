Class {
	#name : #BaselineOfSpec,
	#superclass : #BaselineOf,
	#instVars : [
		'currentManager'
	],
	#category : #BaselineOfSpec
}

{ #category : #baseline }
BaselineOfSpec >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec 
			preLoadDoIt: #useCustomUIManager;
			postLoadDoIt: #restoreOldUIManager.

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

{ #category : #'pre/post load' }
BaselineOfSpec >> restoreOldUIManager [
	
	self shouldInstallHackedUIManager ifFalse: [ ^ self ].
	
	currentManager beDefault
]

{ #category : #'pre/post load' }
BaselineOfSpec >> shouldInstallHackedUIManager [
	^ {CommandLineUIManager. NonInteractiveUIManager} anySatisfy: [ :e | UIManager default isKindOf: e ]
]

{ #category : #'pre/post load' }
BaselineOfSpec >> useCustomUIManager [
	"Metacello pop some UIManager request during the loading of Spec. This cause a problem so we register a new UIManager if we are in non interactive mode that will always say to load the code in anycase."
	UIManager default crLog.
	self shouldInstallHackedUIManager ifFalse: [ ^ self ].
	
	currentManager := UIManager default.
	UIManager default: InImageProjectLoadingUIManager new
]
