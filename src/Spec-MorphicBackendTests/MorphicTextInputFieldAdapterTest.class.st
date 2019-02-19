Class {
	#name : #MorphicTextInputFieldAdapterTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicTextInputFieldAdapterTest >> classToTest [
	^ TextInputFieldPresenter
]

{ #category : #running }
MorphicTextInputFieldAdapterTest >> setUp [

	super setUp.
	presenter buildWithSpec
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testChangeWidgetTextUpdatesPresenter [

	presenter adapter widget setTextAndAccept: 'some text'.
	
	self assert: presenter text equals: 'some text'
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testInvisibilityIsSetInWidget [

	presenter beInvisible.
	self assert: (presenter adapter widget font isKindOf: FixedFaceFont)
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testMaxLengthIsSetInWidget [

	presenter maxLength: 10.
	self assert: presenter adapter widget maxLength equals: 10
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testPresenterPlaceholderIsSetInWidget [

	presenter placeholder: 'something'.
	self assert: presenter adapter widget ghostText equals: 'something'
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testPresenterTextIsSetInWidget [

	presenter text: 'something'.
	self assert: presenter adapter widget text equals: 'something'
]

{ #category : #tests }
MorphicTextInputFieldAdapterTest >> testVisibilityIsSetInWidget [

	presenter beVisible.
	self deny: (presenter adapter widget font isKindOf: FixedFaceFont)
]
