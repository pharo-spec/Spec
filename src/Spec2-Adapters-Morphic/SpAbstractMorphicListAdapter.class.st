"
I am an abstract class with common behaviour for list and table adapters.
See my subclasses for more details.
"
Class {
	#name : #SpAbstractMorphicListAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Adapters-Morphic-List'
}

{ #category : #testing }
SpAbstractMorphicListAdapter class >> isAbstract [
	^ self = SpAbstractMorphicListAdapter
]

{ #category : #scrolling }
SpAbstractMorphicListAdapter >> configureScrolling [
	self presenter verticalAlignment
		whenChangedDo: [ widget
				scrollToIndex: self presenter verticalAlignment desiredVisibleRow ].
			
	self presenter
		whenDisplayDo: [ widget
				scrollToIndex: self presenter verticalAlignment desiredVisibleRow.
			self scrollingChanged ].
		
	widget
		onAnnouncement: FTScrollingChanged
		send: #scrollingChanged
		to: self.
		
	self flag: 'This is a fix to correctly update the scrolling when updating selection. I am not certain this is the right way to do it.'.	
	self presenter selection
		whenChangedDo: [ widget
				scrollToIndex: self presenter verticalAlignment desiredVisibleRow.
			widget selectedIndex > widget lastVisibleRowIndex
				ifTrue: [ widget moveShowIndexTo: widget selectedIndex ] ]
]

{ #category : #'widget API' }
SpAbstractMorphicListAdapter >> elementAt: index [

	^ self widget dataSource elementAt: index
]

{ #category : #'widget API' }
SpAbstractMorphicListAdapter >> itemFilter [
	^ self model itemFilter
]

{ #category : #scrolling }
SpAbstractMorphicListAdapter >> scrollingChanged [
	widget container updateAllRows.
	self presenter verticalAlignment
		firstVisibleRowIndex: widget firstVisibleRowIndex;
		lastVisibleRowIndex: widget lastVisibleRowIndex
]

{ #category : #factory }
SpAbstractMorphicListAdapter >> updateItemFilterBlockWith: block [

	^ block
		ifNotNil: [ 
			widget
				enableFilter: (SpFTSpecFilter block: block);
				explicitFunction ]
		ifNil: [ 
			self updateSearch ]
]

{ #category : #factory }
SpAbstractMorphicListAdapter >> updateSearch [

	self presenter isSearchEnabled
		ifTrue: [ widget enableSearch ]
		ifFalse: [ widget disableFunction ]
]
