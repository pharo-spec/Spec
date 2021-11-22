Class {
	#name : #SpPresenterBuildTest,
	#superclass : #TestCase,
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #tests }
SpPresenterBuildTest >> testBuildPresenterWillSetPresenterProperty [
	| presenter |
	
	presenter := SpPresenter new layout: SpBoxLayout newVertical; yourself.
	presenter buildWithSpec.
	self 
		assert: presenter adapter widget presenter
		equals: presenter.

	presenter := SpPresenter new layout: SpPanedLayout newVertical; yourself.
	presenter buildWithSpec.
	self 
		assert: presenter adapter widget presenter
		equals: presenter.

	presenter := SpPresenter new layout: SpGridLayout new; yourself.
	presenter buildWithSpec.
	self 
		assert: presenter adapter widget presenter
		equals: presenter
]

{ #category : #tests }
SpPresenterBuildTest >> testBuildWidgetPresenterWillSetPresenterProperty [
	| package |

	package := RPackageOrganizer default packageNamed: 'Spec2-Core'.
	SpAbstractWidgetPresenter allSubclasses 
		select: [ :each | 
			(each package = package) 
			and: [ each isAbstract not 
			and: [ each isWindow not ] ] ]
		thenDo: [ :aClass | | presenter | 
			presenter := aClass sampleInstanceForTest.
			presenter buildWithSpec.
			presenter adapter widget isMorph ifTrue: [  
				self 
					assert: presenter adapter widget presenter
					equals: presenter ] ]
]
