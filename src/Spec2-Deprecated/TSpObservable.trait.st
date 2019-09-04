Trait {
	#name : #TSpObservable,
	#traits : 'SpTObservable',
	#classTraits : 'SpTObservable classTrait',
	#category : #'Spec2-Deprecated'
}

{ #category : #testing }
TSpObservable classSide >> isDeprecated [
	"Use SpTObservable instead"

	^ true
]
