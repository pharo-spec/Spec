Class {
	#name : 'SpAbstractEasyListViewPresenter',
	#superclass : 'SpAbstractEasyPresenter',
	#classTraits : 'SpTSearchable classTrait',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> listSize [

	^ contentView listSize
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectIndex: anInteger [ 
	
	contentView selectIndex: anInteger
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectedItems [
	
	^ contentView selectedItems
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selection [
	
	^ contentView selection
]

{ #category : 'api - events' }
SpAbstractEasyListViewPresenter >> whenModelChangedDo: aBlock [

	contentView whenModelChangedDo: aBlock
]
