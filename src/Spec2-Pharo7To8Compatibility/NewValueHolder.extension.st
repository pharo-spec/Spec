Extension { #name : #NewValueHolder }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
NewValueHolder >> valueChanged [
	
	self announcer announce: (ValueChanged newValue: self value)
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
NewValueHolder >> valueChanged: oldValue [
	
	self announcer announce: (ValueChanged oldValue: oldValue newValue: self value)
]
