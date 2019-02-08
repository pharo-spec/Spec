"
A TableBasePresenterTest is a test class for testing the behavior of TableBasePresenter
"
Class {
	#name : #TableBasePresenterTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #testing }
TableBasePresenterTest class >> isAbstract [
	^ self = TableBasePresenterTest
]

{ #category : #helpers }
TableBasePresenterTest >> columnToAdd [
	^ self subclassResponsibility
]

{ #category : #helpers }
TableBasePresenterTest >> elementAtTheSecondIndex [
	^ self subclassResponsibility
]

{ #category : #tests }
TableBasePresenterTest >> testAddColumn [
	self assertEmpty: presenter columns.
	presenter addColumn: self columnToAdd.
	self assert: presenter columns size equals: 1
]

{ #category : #test }
TableBasePresenterTest >> testSelectIndex [
	| selectedIndexChanged |
	selectedIndexChanged := false.
	presenter whenSelectedIndexChangedDo: [ selectedIndexChanged := true ].
	presenter selectIndex: 2.
	self assert: selectedIndexChanged.
	self assert: presenter selectedIndex equals: 2.
	self assert: presenter selectedItem equals: self elementAtTheSecondIndex
]

{ #category : #test }
TableBasePresenterTest >> testSelectItem [
	| selectedItemChanged |
	selectedItemChanged := false.
	presenter whenSelectedItemChangedDo: [ selectedItemChanged := true ].
	presenter selectItem: self elementAtTheSecondIndex.
	self assert: selectedItemChanged.
	self assert: presenter selectedItem equals: self elementAtTheSecondIndex.
	self assert: presenter selectedIndex equals: 2
]

{ #category : #test }
TableBasePresenterTest >> testWhenIsResizableChangedDo [
	| count element |
	count := 0.
	presenter
		whenIsResizableChangedDo: [ :new | 
			count := count + 1.
			element := new ].
	presenter beResizable.
	self assert: count equals: 1.
	self assert: element.
	presenter beNotResizable.
	self assert: count equals: 2.
	self deny: element
]

{ #category : #test }
TableBasePresenterTest >> testWhenSelectedIndexChangedDo [
	"We need to change the selection implementation to make this test pass"

	<expectedFailure>
	| count element |
	count := 0.
	presenter
		whenSelectedIndexChangedDo: [ :new | 
			count := count + 1.
			element := new ].
	presenter selectedIndex: 2.
	self assert: count equals: 1.
	self assert: element equals: self elementAtTheSecondIndex
]

{ #category : #test }
TableBasePresenterTest >> testWhenSelectedItemChangedDo [
	"We need to change the selection implementation to make this test pass"

	<expectedFailure>
	| count element |
	count := 0.
	presenter
		whenSelectedItemChangedDo: [ :new | 
			count := count + 1.
			element := new ].
	presenter selected: self elementAtTheSecondIndex.
	self assert: count equals: 1.
	self assert: element equals: self elementAtTheSecondIndex
]
