Class {
	#name : 'SpActionTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Commander2-Tests',
	#package : 'Spec2-Commander2-Tests'
}

{ #category : 'helpers' }
SpActionTest >> iconNamed: aSymbol [
	"Stands in for the icon provider, so the tests do not depend on the theme's icons."

	^ #icon -> aSymbol
]

{ #category : 'tests' }
SpActionTest >> testDynamicIconIsNilWithoutIconName [

	| action |
	action := SpAction newName: 'Mark' action: [ ].

	self assert: action dynamicIcon isNil
]

{ #category : 'tests' }
SpActionTest >> testDynamicIconIsTheIconOfDynamicIconName [

	| action |
	action := SpAction newName: 'Mark' iconName: #smallOk action: [ ].
	action
		iconProvider: self;
		dynamicIconName: [ #smallUndo ].

	self assert: action dynamicIcon equals: (self iconNamed: #smallUndo)
]

{ #category : 'tests' }
SpActionTest >> testDynamicIconNameAnswersIconNameByDefault [

	| action |
	action := SpAction newName: 'Mark' iconName: #smallOk action: [ ].

	self assert: action dynamicIconName equals: #smallOk
]

{ #category : 'tests' }
SpActionTest >> testDynamicIconNameEvaluatesBlockWithContext [

	| action |
	action := SpAction newName: 'Mark' iconName: #smallOk action: [ ].
	action
		context: true;
		dynamicIconName: [ :isReviewed |
			isReviewed
				ifTrue: [ #smallUndo ]
				ifFalse: [ #smallOk ] ].

	self assert: action dynamicIconName equals: #smallUndo.

	action context: false.
	self assert: action dynamicIconName equals: #smallOk
]
