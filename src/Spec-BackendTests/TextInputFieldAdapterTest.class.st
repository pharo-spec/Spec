Class {
	#name : #TextInputFieldAdapterTest,
	#superclass : #AbstractAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
TextInputFieldAdapterTest >> classToTest [
	^ TextInputFieldPresenter
]

{ #category : #tests }
TextInputFieldAdapterTest >> testChangePlaceholderTextUpdatesPresenter [

	presenter placeholder: 'some text'.
	
	self assert: self adapter placeHolderText equals: 'some text'
]

{ #category : #tests }
TextInputFieldAdapterTest >> testChangeWidgetTextUpdatesPresenter [

	self adapter text: 'some text'.
	
	self assert: presenter text equals: 'some text'
]

{ #category : #tests }
TextInputFieldAdapterTest >> testInvisibilityIsSetInWidget [

	presenter beInvisible.
	self assert: self adapter isPassword
]

{ #category : #tests }
TextInputFieldAdapterTest >> testMaxLengthIsSetInWidget [

	presenter maxLength: 10.
	self assert: self widget maxLength equals: 10
]

{ #category : #tests }
TextInputFieldAdapterTest >> testPresenterPlaceholderIsSetInWidget [

	presenter placeholder: 'something'.
	self assert: self adapter placeHolderText equals: 'something'
]

{ #category : #tests }
TextInputFieldAdapterTest >> testPresenterTextIsSetInWidget [

	presenter text: 'something'.
	self assert: self widget text equals: 'something'
]

{ #category : #tests }
TextInputFieldAdapterTest >> testVisibilityIsSetInWidget [

	presenter beVisible.
	self deny: self adapter isPassword
]
