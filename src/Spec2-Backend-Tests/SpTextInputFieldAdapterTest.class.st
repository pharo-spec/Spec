Class {
	#name : 'SpTextInputFieldAdapterTest',
	#superclass : 'SpAbstractTextAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTextInputFieldAdapterTest >> classToTest [
	^ SpTextInputFieldPresenter
]

{ #category : 'tests' }
SpTextInputFieldAdapterTest >> testChangeWidgetTextUpdatesPresenter [

	self adapter text: 'some text'.
	
	self assert: presenter text equals: 'some text'
]

{ #category : 'tests' }
SpTextInputFieldAdapterTest >> testMaxLengthIsSetInWidget [

	presenter
		maxLength: 4;
		type: '1234567'.

	self assert: self adapter getText equals: '1234'
]

{ #category : 'tests' }
SpTextInputFieldAdapterTest >> testNotPasswordIsSetInWidget [

	presenter bePassword: false.
	self deny: self adapter isPassword
]

{ #category : 'tests' }
SpTextInputFieldAdapterTest >> testPasswordIsSetInWidget [

	presenter
		bePassword;
		type: '1234'.

	self assert: self adapter isPassword.
	self assert: self adapter getText equals: '1234'
]

{ #category : 'tests' }
SpTextInputFieldAdapterTest >> testPresenterTextIsSetInWidget [

	presenter text: 'something'.
	self assert: self adapter getText equals: 'something'
]
