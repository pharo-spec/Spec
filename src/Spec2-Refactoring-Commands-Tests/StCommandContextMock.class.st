Class {
	#name : 'StCommandContextMock',
	#superclass : 'Object',
	#instVars : [
		'selectedMethod',
		'name'
	],
	#category : 'Spec2-Refactoring-Commands-Tests',
	#package : 'Spec2-Refactoring-Commands-Tests'
}

{ #category : 'private - scopes' }
StCommandContextMock >> allScopes [

	^ { RBBrowserEnvironment default }
]

{ #category : 'accessing' }
StCommandContextMock >> application [

	^ StPharoApplication new
]

{ #category : 'accessing' }
StCommandContextMock >> codePresenter [

^ self
]

{ #category : 'accessing' }
StCommandContextMock >> name [

	^ name
]

{ #category : 'accessing' }
StCommandContextMock >> name: aName [

	name := aName
]

{ #category : 'accessing' }
StCommandContextMock >> selectedMethod [

	^ selectedMethod
]

{ #category : 'accessing' }
StCommandContextMock >> selectedMethod: aCompiledMethod [

	selectedMethod := aCompiledMethod
]

{ #category : 'accessing' }
StCommandContextMock >> selectedNode [

	^ self
]
