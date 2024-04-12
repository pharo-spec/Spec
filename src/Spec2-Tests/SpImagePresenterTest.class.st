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
SpImagePresenterTest >> testAutoScale [
	| count result |
	count := 0.
	presenter
		whenAutoScaleChangeDo: [ :value | 
			result := value.
			count := count + 1 ].
	presenter autoScale: true.
	self assert: count equals: 1.
	self assert: result
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

{ #category : 'tests' }
SpImagePresenterTest >> testSwitchAutoScale [
	| autoState |
	autoState := presenter autoScale.
	presenter switchAutoscale.
	self assert: presenter autoScale equals: autoState not
]
