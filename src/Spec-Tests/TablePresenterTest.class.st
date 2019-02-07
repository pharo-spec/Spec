Class {
	#name : #TablePresenterTest,
	#superclass : #TableBasePresenterTest,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
TablePresenterTest >> classToTest [
	^ TablePresenter
]

{ #category : #helpers }
TablePresenterTest >> columnToAdd [
	^ StringTableColumn title: 'Number' evaluated: #asString
]

{ #category : #test }
TablePresenterTest >> elementAtTheSecondIndex [
	^ 20
]

{ #category : #running }
TablePresenterTest >> setUp [
	super setUp.
	presenter items: #(10 20 30)
]

{ #category : #test }
TablePresenterTest >> testItemAt [
	self assert: (presenter itemAt: 1) equals: 10.
	self assert: (presenter itemAt: 2) equals: 20
]
