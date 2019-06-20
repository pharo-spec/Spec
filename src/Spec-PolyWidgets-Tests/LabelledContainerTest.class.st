Class {
	#name : #LabelledContainerTest,
	#superclass : #SpSmokeTestCase,
	#category : #'Spec-PolyWidgets-Tests'
}

{ #category : #running }
LabelledContainerTest >> classToTest [
	^ LabelledContainer
]

{ #category : #running }
LabelledContainerTest >> initializeTestedInstance [
	presenter content: SpTestingComposablePresenter.
]

{ #category : #tests }
LabelledContainerTest >> testContent [
	presenter content: SpListPresenter.
	self assert: presenter subwidget class equals: SpListPresenter
]

{ #category : #tests }
LabelledContainerTest >> testDoesNotUnderstand [
	presenter content: SpListPresenter.
	presenter items: {'aaa' . 'bbb' . 'ccc'}.
	self assertCollection: presenter model items hasSameElements: {'aaa' . 'bbb' . 'ccc'}
]

{ #category : #tests }
LabelledContainerTest >> testLabelBottom [
	self openInstance: #labelBottom
]

{ #category : #tests }
LabelledContainerTest >> testLabelLeft [
	self openInstance:#labelLeft
]

{ #category : #tests }
LabelledContainerTest >> testLabelRight [
	self openInstance:#labelRight
]
