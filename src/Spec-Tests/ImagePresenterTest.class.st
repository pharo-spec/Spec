Class {
	#name : #ImagePresenterTest,
	#superclass : #SpSmokeTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ImagePresenterTest >> classToTest [
	^ ImagePresenter
]

{ #category : #tests }
ImagePresenterTest >> testAutoScale [
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

{ #category : #tests }
ImagePresenterTest >> testSwitchAutoScale [
	| autoState |
	autoState := presenter autoScale.
	presenter switchAutoscale.
	self assert: presenter autoScale equals: autoState not
]
