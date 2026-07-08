Class {
	#name : 'SpImagePresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpImagePresenterTest >> classToTest [
	^ SpImagePresenter
]

{ #category : 'running' }
SpImagePresenterTest >> tearDown [ 

	presenter ifNotNil: [ presenter delete ].
	super tearDown
]

{ #category : 'tests' }
SpImagePresenterTest >> testCanDefineImagePresenterFromAForm [
	| title form windowPresenter presenterItems |
	
	presenter := windowPresenter := SpPresenter new
		layout: (SpBoxLayout newLeftToRight
			add: (title := 'Image added directly from the layout definition:');
			add: (form := self iconNamed: #pharoBig);
			yourself);
		open.
	
	presenterItems := windowPresenter presenter layout children.
	self assert: presenterItems first equals: title.
	self assert: presenterItems second equals: form.
	
]
