Class {
	#name : 'StCommandContextMock',
	#superclass : 'Object',
	#instVars : [
		'selectedMethod',
		'name',
		'sourceInterval',
		'selector',
		'origin',
		'selectedNode'
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
StCommandContextMock >> codeEditor [

	^ self
]

{ #category : 'accessing' }
StCommandContextMock >> codePresenter [

^ self
]

{ #category : 'testing' }
StCommandContextMock >> isInstanceSide [

	^ true
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

	^ selectedNode ifNil: [ self ]
]

{ #category : 'accessing' }
StCommandContextMock >> selectedNode: aNode [

	selectedNode := aNode
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
