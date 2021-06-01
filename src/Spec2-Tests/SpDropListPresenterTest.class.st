Class {
	#name : #SpDropListPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpDropListPresenterTest >> classToTest [
	^ SpDropListPresenter
]

{ #category : #'as yet unclassified' }
SpDropListPresenterTest >> testDisableSelectionDuring [ 
	| changed |

	changed := false.
	presenter items: #($a $b $c).
	presenter selectItem: $a.
	presenter whenSelectionChangedDo: [ changed := true ].
	
	self deny: changed.
	presenter disableSelectionDuring: [ presenter selectItem: $b ].
	self deny: changed. "still not change"
	self assert: presenter selectedItem equals: $b "but the selection changed!"
]

{ #category : #tests }
SpDropListPresenterTest >> testSortingBlock [
	| count |
	count := 0.
	presenter
		whenSortingBlockChangedDo: [ :sortFunction | count := count + 1 ].
	presenter items: #(3 8 1 0).
	presenter sortingBlock: [ :a :b | a model < b model ].
	self assert: count equals: 1.
	self assert: (presenter model at: 1) model equals: 0
]

{ #category : #'as yet unclassified' }
SpDropListPresenterTest >> testUpdateItemsKeepingSelection [ 

	presenter items: #($a $b $c).
	presenter selectItem: $c.
	presenter updateItemsKeepingSelection: #($c $d $e $f).
	self assert: presenter selectedItem equals: $c
]
