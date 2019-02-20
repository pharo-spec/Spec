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

{ #category : #tests }
TableBasePresenterTest >> testAddColumn [
	self assertEmpty: presenter columns.
	presenter addColumn: self columnToAdd.
	self assert: presenter columns size equals: 1
]

{ #category : #tests }
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
