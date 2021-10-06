Class {
	#name : #SpToolbarToggleButtonMorphTest,
	#superclass : #SpSmokeTest,
	#traits : 'SpTMorphicUIRedrawer',
	#classTraits : 'SpTMorphicUIRedrawer classTrait',
	#category : #'Spec2-Morphic-Tests-Examples'
}

{ #category : #accessing }
SpToolbarToggleButtonMorphTest >> classToTest [

	^ SpToolbarToggleButtonPresenter 
]

{ #category : #initialization }
SpToolbarToggleButtonMorphTest >> initialize [

	super initialize.
	self initializeSemaphore
]

{ #category : #tests }
SpToolbarToggleButtonMorphTest >> testClickDeactivatedCheckboxActivatesIt [
	| state |

	state := presenter isSelected.

	self openInstance.
	self waitUntilUIRedrawed.
	presenter adapter widget simulateClick.
	self waitUntilUIRedrawed.

	self assert: presenter isSelected equals: state not
]
