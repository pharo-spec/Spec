Class {
	#name : 'SpEasyListViewPresenterTest',
	#superclass : 'SpListViewPresenterTest',
	#category : 'Spec2-ListView-Tests',
	#package : 'Spec2-ListView-Tests'
}

{ #category : 'accessing' }
SpEasyListViewPresenterTest >> classToTest [
	
	^ SpEasyListViewPresenter
]

{ #category : 'initialization' }
SpEasyListViewPresenterTest >> initializeTestedInstance [
]

{ #category : 'tests - header' }
SpEasyListViewPresenterTest >> testHideHeaderTitleUnsetsTitle [

	presenter
		headerTitle: 'title';
		hideHeaderTitle.
	
	self deny: presenter hasHeaderTitle
]

{ #category : 'tests - header' }
SpEasyListViewPresenterTest >> testIconFor [
	presenter
		items: #(#add #back #catalog);
		displayIcon: [ :item | Smalltalk ui icons iconNamed: item asSymbol ].
	self assert: (presenter iconFor: #add) equals: (Smalltalk ui icons iconNamed: #add)
]

{ #category : 'tests - header' }
SpEasyListViewPresenterTest >> testSetHeaderTitleHasTitle [

	presenter headerTitle: 'title'.
	
	self assert: presenter hasHeaderTitle
]

{ #category : 'tests - header' }
SpEasyListViewPresenterTest >> testSetHeaderTitleSetsTitle [

	presenter headerTitle: 'title'.
	
	self assert: presenter headerTitle equals: 'title'
]

{ #category : 'tests' }
SpEasyListViewPresenterTest >> testWhenIconsChangedDo [
	| icon counter |

	counter := 0.
	presenter whenIconsChangedDo: [ :iconBlock | 
		icon := iconBlock cull: #add.
		counter := counter + 1 ].
	presenter displayIcon: [ :item | Smalltalk ui icons iconNamed: item asSymbol ].
	self assert: icon equals: (Smalltalk ui icons iconNamed: #add).
	self assert: counter equals: 1
]
