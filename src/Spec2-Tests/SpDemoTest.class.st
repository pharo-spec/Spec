Class {
	#name : #SpDemoTest,
	#superclass : #SpSmokeTestCase,
	#category : #'Spec2-Tests-Examples'
}

{ #category : #running }
SpDemoTest >> classToTest [
	^ SpDemo
]

{ #category : #tests }
SpDemoTest >> testSmokeTestForDemoPages [
	self timeLimit: 1 minute. 
	SpDemoPage availablePages
		do: [ :demoPage | 
			[ self shouldnt: [ window := demoPage new openWithSpec ] raise: Error description: 'Broken demo page: ' , demoPage asString ]
				ensure: [ window ifNotNil: #close ] ]
]
