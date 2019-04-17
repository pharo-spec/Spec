Extension { #name : #TestAsserter }

{ #category : #'*Spec-Pharo7To8Compatibility' }
TestAsserter >> assertEmpty: aCollection [
	^ self assert: aCollection isEmpty description: aCollection asString , ' should have been empty'
]

{ #category : #'*Spec-Pharo7To8Compatibility' }
TestAsserter >> denyEmpty: aCollection [
	^ self assert: aCollection isNotEmpty description: aCollection asString , ' should not have been empty'
]
