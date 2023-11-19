Extension { #name : 'TAssertable' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
TAssertable >> assertEmpty: aCollection [
	^ self assert: aCollection isEmpty description: aCollection asString , ' should have been empty'
]

{ #category : '*Spec2-Pharo7To8Compatibility' }
TAssertable >> denyEmpty: aCollection [
	^ self assert: aCollection isNotEmpty description: aCollection asString , ' should not have been empty'
]
