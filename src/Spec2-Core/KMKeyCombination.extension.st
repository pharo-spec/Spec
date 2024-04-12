Extension { #name : 'KMKeyCombination' }

{ #category : '*Spec2-Core' }
KMKeyCombination >> actionModifier [
	"Define the action action modifier depending in which platform we are running.
	 e.g. $x actionModifier will resolve in $x ctrl in unix and windows systems and $x command 
	 in mac"

	^ (KMModifier command + self) mac 
		| (KMModifier control + self) unix 
		| (KMModifier control + self) win
]
