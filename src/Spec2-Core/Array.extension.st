Extension { #name : #Array }

{ #category : #'*Spec2-Core' }
Array >> asSpLayout [
	^ SpLegacyArrayLayout new
		array: self;
		yourself
]

{ #category : #'*Spec2-Core' }
Array >> generateSpec [
	| str spec |
	str := self readStream.	
	
	spec :=  OrderedCollection with: #SpLayoutFrame.
		
	#( leftFraction: topFraction: rightFraction: bottomFraction: leftOffset: topOffset: rightOffset: bottomOffset: ) do: [:sel |
		spec add: sel.
		str next ifNil: [ spec add: 0 ] ifNotNil: [:value | spec add: value ]].
	^ spec asArray
]
