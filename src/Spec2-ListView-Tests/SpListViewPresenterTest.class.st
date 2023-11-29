Class {
	#name : 'SpListViewPresenterTest',
	#superclass : 'SpAbstractListPresenterTest',
	#category : 'Spec2-ListView-Tests',
	#package : 'Spec2-ListView-Tests'
}

{ #category : 'accessing' }
SpListViewPresenterTest >> classToTest [
	
	^ SpListViewPresenter
]

{ #category : 'initialization' }
SpListViewPresenterTest >> initializeTestedInstance [

	presenter
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :anObject | aPresenter label: anObject asString ]
]

{ #category : 'running' }
SpListViewPresenterTest >> tearDown [

	presenter withWindowDo: [ :w | w close ]
]
