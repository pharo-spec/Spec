Class {
	#name : 'SpActionMenuPresenterBuilderTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Commander2-Tests',
	#package : 'Spec2-Commander2-Tests'
}

{ #category : 'helpers' }
SpActionMenuPresenterBuilderTest >> iconNamed: aSymbol [
	"Stands in for the icon provider, so the tests do not depend on the theme's icons."

	^ #icon -> aSymbol
]

{ #category : 'helpers' }
SpActionMenuPresenterBuilderTest >> menuItemFor: anAction [

	| builder |
	builder := SpActionMenuPresenterBuilder new.
	anAction acceptVisitor: builder.
	^ builder menuPresenter defaultGroup menuItems first
]

{ #category : 'tests' }
SpActionMenuPresenterBuilderTest >> testMenuItemHasNoIconWithoutIconName [

	self assert: (self menuItemFor: (SpAction newName: 'Reviewed' action: [ ])) icon isNil
]

{ #category : 'tests' }
SpActionMenuPresenterBuilderTest >> testMenuItemIconFollowsDynamicIconName [

	| action isReviewed |
	isReviewed := false.
	action := SpAction newName: 'Reviewed' iconName: #smallOk action: [ ].
	action
		iconProvider: self;
		dynamicName: [
			isReviewed
				ifTrue: [ 'Unmark' ]
				ifFalse: [ 'Reviewed' ] ];
		dynamicIconName: [
			isReviewed
				ifTrue: [ #smallUndo ]
				ifFalse: [ #smallOk ] ].

	self assert: (self menuItemFor: action) name equals: 'Reviewed'.
	self assert: (self menuItemFor: action) icon equals: (self iconNamed: #smallOk).

	isReviewed := true.
	self assert: (self menuItemFor: action) name equals: 'Unmark'.
	self assert: (self menuItemFor: action) icon equals: (self iconNamed: #smallUndo)
]

{ #category : 'tests' }
SpActionMenuPresenterBuilderTest >> testMenuItemIconIsIconWithoutDynamicIconName [

	| action |
	action := SpAction newName: 'Reviewed' iconName: #smallOk action: [ ].
	action iconProvider: self.

	self assert: (self menuItemFor: action) icon equals: (self iconNamed: #smallOk)
]
