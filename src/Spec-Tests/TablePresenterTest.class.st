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

{ #category : #test }
TablePresenterTest >> testSelectIndex [
	| selectedIndexChanged |
	selectedIndexChanged := false.
	presenter whenSelectedIndexChangedDo: [ selectedIndexChanged := true ].
	presenter selectIndex: 2.
	self assert: selectedIndexChanged.
	self assert: presenter selectedIndex equals: 2.
	self assert: presenter selectedItem equals: self elementAtTheSecondIndex
]

{ #category : #test }
TablePresenterTest >> testSelectItem [
	| selectedItemChanged |
	selectedItemChanged := false.
	presenter whenSelectedItemChangedDo: [ selectedItemChanged := true ].
	presenter selectItem: self elementAtTheSecondIndex.
	self assert: selectedItemChanged.
	self assert: presenter selectedItem equals: self elementAtTheSecondIndex.
	self assert: presenter selectedIndex equals: 2
]

{ #category : #test }
TablePresenterTest >> testWhenSelectedIndexChangedDo [
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
TablePresenterTest >> testWhenSelectedItemChangedDo [
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
