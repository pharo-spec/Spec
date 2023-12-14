Extension { #name : 'KMPlatformSpecificKeyCombination' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
KMPlatformSpecificKeyCombination >> platformCharacter [

	^ (self platform = #all or: [ self platform = OSPlatform current platformFamily ])
		ifTrue: [ self shortcut platformCharacter ]
		ifFalse: [ nil ]
]

{ #category : '*Spec2-Pharo7To8Compatibility' }
KMPlatformSpecificKeyCombination >> platformModifier [

	^ (self platform = #all or: [ self platform = OSPlatform current platformFamily ])
		ifTrue: [ self shortcut platformModifier ]
		ifFalse: [ nil ]
]
