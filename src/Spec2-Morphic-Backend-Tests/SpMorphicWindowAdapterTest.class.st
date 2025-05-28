Class {
	#name : 'SpMorphicWindowAdapterTest',
	#superclass : 'TestCase',
	#instVars : [
		'window'
	],
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'running' }
SpMorphicWindowAdapterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown
]

{ #category : 'tests' }
SpMorphicWindowAdapterTest >> testCanForceNonModalOpenWhenUsingBlockedDialogWindow [

	| presenter |
	presenter := SpButtonPresenter new.
	SpWindowForceOpenNonModal during: [ 
		window := presenter openBlockedDialog ].
	
	self assert: SpWindowForceOpenNonModal value equals: false
]

{ #category : 'tests' }
SpMorphicWindowAdapterTest >> testCanForceNonModalOpenWhenUsingModalWindow [

	| presenter |
	presenter := SpButtonPresenter new.
	SpWindowForceOpenNonModal during: [ 
		window := presenter openModal ].
	
	self assert: SpWindowForceOpenNonModal value equals: false

]

{ #category : 'tests' }
SpMorphicWindowAdapterTest >> testOpenWidgetPresenterAppliesStyle [

	| presenter |
	presenter := SpTextPresenter new.
	[ window := presenter open ] ensure: [ window close ].

	self assert: presenter adapter widget font equals: StandardFonts defaultFont.

	presenter := SpTextPresenter new.
	presenter addStyle: 'code'.
	[ window := presenter open ] ensure: [ window close ].

	self assert: presenter adapter widget font equals: StandardFonts codeFont
]
