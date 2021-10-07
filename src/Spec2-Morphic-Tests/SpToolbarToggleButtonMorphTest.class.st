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

	self flag: #FIXME. "This test is not passing on spec-all CI (even if it passes in 
	local and in spec-basic CI)"
	self skipOnPharoCITestingEnvironment.

	state := presenter isSelected.

	self openInstance.
	self waitUntilUIRedrawed.
	presenter adapter widget simulateClick.
	self waitUntilUIRedrawed.

	self assert: presenter isSelected equals: state not
]
