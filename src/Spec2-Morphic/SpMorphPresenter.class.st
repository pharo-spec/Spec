Class {
	#name : #SpMorphPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#morph => SpObservableSlot'
	],
	#category : #'Spec2-Morphic'
}

{ #category : #specs }
SpMorphPresenter class >> adapterName [

	^ #MorphAdapter
]

{ #category : #'handling transmission' }
SpMorphPresenter >> defaultInputPort [

	^ self inputMorphPort
]

{ #category : #initialization }
SpMorphPresenter >> initialize [
	super initialize.
]

{ #category : #'handling transmission' }
SpMorphPresenter >> inputMorphPort [ 

	^ SpMorphPort newPresenter: self
]

{ #category : #accessing }
SpMorphPresenter >> morph [
	^ morph
]

{ #category : #accessing }
SpMorphPresenter >> morph: aMorph [

	morph := aMorph
]

{ #category : #'api-events' }
SpMorphPresenter >> whenMorphChangedDo: aBlock [ 

	self property: #morph whenChangedDo: aBlock
]
