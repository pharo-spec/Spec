Extension { #name : #SpecApplication }

{ #category : #'*Spec-CommandLine' }
SpecApplication class >> applicationName [

	^ nil
]

{ #category : #'*Spec-CommandLine' }
SpecApplication class >> findAll [

	^ self allSubclasses select: [ :each | each applicationName notNil ] 
]

{ #category : #'*Spec-CommandLine' }
SpecApplication class >> findNamed: aString ifNone: aBlock [

	^ self allSubclasses 
		detect: [ :each | each applicationName = aString ]
		ifNone: aBlock
]

{ #category : #'*Spec-CommandLine' }
SpecApplication >> prepareAsStandaloneApplication [
	"override this to specify  standalone settings"
]
