Extension { #name : 'SpApplication' }

{ #category : '*Spec2-Code' }
SpApplication >> codeShowLineNumbers [

	^ self
		  propertyAt: #codeShowLineNumbers
		  ifAbsentPut: [ self class defaultCodeShowLineNumbers ]
]

{ #category : '*Spec2-Code' }
SpApplication class >> defaultCodeShowLineNumbers [

	^ true
]
