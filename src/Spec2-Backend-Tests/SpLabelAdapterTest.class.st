"
SUnit tests for MorphicLabelAdapter
"
Class {
	#name : 'SpLabelAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpLabelAdapterTest >> classToTest [
	^ SpLabelPresenter
]

{ #category : 'tests' }
SpLabelAdapterTest >> testBackgroundColorChangesColor [
	"test this issue: https://github.com/pharo-spec/Spec/issues/1524"
	
	presenter label: 'Test'.
	presenter displayBackgroundColor: [ Color green ].
	self openInstance.
	self assert: self adapter backgroundColor equals: Color green
]

{ #category : 'tests' }
SpLabelAdapterTest >> testBeNotWrapAfterOpeningShowsOneLine [

	presenter
		label: 'A long label that cannot fit on one line in a narrow window';
		beWrap.
	self openInstance.
	
	self window resize: 150 @ 300.

	presenter beNotWrap.

	self assert: self adapter numberOfLines equals: 1
]

{ #category : 'tests' }
SpLabelAdapterTest >> testBeWrapAfterOpeningShowsSeveralLines [

	presenter label: 'A long label that cannot fit on one line in a narrow window'.
	self openInstance.
	self window resize: 150 @ 300.
	self assert: self adapter numberOfLines equals: 1.

	presenter beWrap.

	self assert: self adapter numberOfLines > 1
]

{ #category : 'tests' }
SpLabelAdapterTest >> testChangingHelpAfterOpeningAffectsTheWidget [

	self adapter.
	presenter help: 'ALabel'.
	self assert: self adapter helpText equals: 'ALabel'
]

{ #category : 'tests' }
SpLabelAdapterTest >> testChangingHelpOfWrappingLabelAfterOpeningAffectsTheWidget [

	presenter beWrap.
	self adapter.
	presenter help: 'ALabel'.
	self assert: self adapter helpText equals: 'ALabel'
]

{ #category : 'tests' }
SpLabelAdapterTest >> testSetLabelInPresenterAffectsWidget [
	presenter label: 'something'.
	self assert: self adapter label equals: 'something'
]

{ #category : 'tests' }
SpLabelAdapterTest >> testSetLabelInWrappingPresenterAffectsWidget [

	presenter beWrap.
	presenter label: 'something'.
	self assert: self adapter label equals: 'something'
]

{ #category : 'tests' }
SpLabelAdapterTest >> testWrappingLabelInNarrowWindowShowsSeveralLines [

	presenter
		label: 'A long label that cannot fit on one line in a narrow window';
		beWrap.
	self openInstance.
	self window resize: 150 @ 300.

	self assert: self adapter numberOfLines > 1
]
