Extension { #name : 'Character' }

{ #category : '*Spec2-Core' }
Character >> actionModifier [
	"Define the action action modifier depending in which platform we are running.
	 e.g. $x actionModifier will resolve in $x ctrl in unix and windows systems and $x command 
	 in mac"

	^ self asKeyCombination actionModifier
]
