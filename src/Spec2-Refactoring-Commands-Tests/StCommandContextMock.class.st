Class {
	#name : 'StCommandContextMock',
	#superclass : 'Object',
	#instVars : [
		'selectedMethod',
		'name',
		'sourceInterval',
		'selector',
		'origin'
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
StCommandContextMock >> origin [

	^ origin
]

{ #category : 'accessing' }
StCommandContextMock >> origin: aClass [

	origin := aClass 
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

{ #category : 'accessing' }
StCommandContextMock >> selector [

	^ selector
]

{ #category : 'accessing' }
StCommandContextMock >> selector: aSelector [

	selector := aSelector
]

{ #category : 'accessing' }
StCommandContextMock >> sourceInterval [

	^ sourceInterval
]

{ #category : 'accessing' }
StCommandContextMock >> sourceInterval: anInterval [

	sourceInterval := anInterval
]

{ #category : 'evaluating' }
StCommandContextMock >> value [

	^ self
]
