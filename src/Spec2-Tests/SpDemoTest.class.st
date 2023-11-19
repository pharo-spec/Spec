Class {
	#name : 'SpDemoTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Examples',
	#package : 'Spec2-Tests',
	#tag : 'Examples'
}

{ #category : 'accessing' }
SpDemoTest >> classToTest [
	^ SpDemo
]

{ #category : 'tests' }
SpDemoTest >> testSmokeTestForDemoPages [

	self timeLimit: 1 minute.
	"We could use #shouldnt:raise: but this way give us the stack of the error"
	SpDemoPage availablePages do: [ :demoPage | 
		[ 
		[ window := demoPage new open ]
			on: Error
			do: [ :e | 
				self fail: 'Broken demo page: ' , demoPage asString , '

' , e signalerContext shortStack ] ] ensure: [ 
			window ifNotNil: #close ] ]
]
