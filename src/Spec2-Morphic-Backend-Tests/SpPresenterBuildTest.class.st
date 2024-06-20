Class {
	#name : 'SpPresenterBuildTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Morphic-Backend-Tests',
	#package : 'Spec2-Morphic-Backend-Tests'
}

{ #category : 'tests' }
SpPresenterBuildTest >> testBuildPresenterWillSetPresenterProperty [

	| presenter |
	presenter := SpPresenter new
		             layout: SpBoxLayout newVertical;
		             yourself.
	presenter build.
	self assert: presenter adapter widget presenter equals: presenter.

	presenter := SpPresenter new
		             layout: SpPanedLayout newVertical;
		             yourself.
	presenter build.
	self assert: presenter adapter widget presenter equals: presenter.

	presenter := SpPresenter new
		             layout: SpGridLayout new;
		             yourself.
	presenter build.
	self assert: presenter adapter widget presenter equals: presenter
]

{ #category : 'tests' }
SpPresenterBuildTest >> testBuildWidgetPresenterWillSetPresenterProperty [

	| package |
	package := self class packageOrganizer packageNamed: 'Spec2-Core'.
	SpAbstractWidgetPresenter allSubclasses
		select: [ :each | 
			each package = package and: [ 
				each isAbstract not and: [ each isWindow not ] ] ]
		thenDo: [ :aClass | 
			| presenter |
			presenter := aClass sampleInstanceForTest.
			presenter build.
			presenter adapter widget isMorph ifTrue: [ 
				self assert: presenter adapter widget presenter equals: presenter ] ]
]

{ #category : 'tests' }
SpPresenterBuildTest >> testBuildWithoutLayoutRaiseError [
	| presenter |
	
	presenter := SpPresenter new.
	
	self 
		should: [ presenter build ]
		raise: Error
		whoseDescriptionIncludes: '#defaulLayout'
		description: 'Build does not raise Missing layout!'
		
]
