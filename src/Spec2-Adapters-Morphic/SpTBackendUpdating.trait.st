"
Add functionality to verify if there is a backend updating in course. 
This is used to prevent cycles when announcing changes from-to the backend.
"
Trait {
	#name : 'SpTBackendUpdating',
	#instVars : [
		'backendUpdating'
	],
	#traits : 'TEmpty',
	#classTraits : 'TEmpty classTrait',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'private' }
SpTBackendUpdating >> backendUpdatingDo: aBlock [ 
	| oldStatus |

	oldStatus := backendUpdating.
	backendUpdating := true.
	aBlock ensure: [ 
		backendUpdating := oldStatus ]
]

{ #category : 'initialization' }
SpTBackendUpdating >> initializeTBackendUpdating [

	backendUpdating := false
]

{ #category : 'private' }
SpTBackendUpdating >> isBackendUpdating [

	^ backendUpdating
]

{ #category : 'private' }
SpTBackendUpdating >> withCycleDetectionOnBackendDo: aBlock [ 

	self isBackendUpdating ifTrue: [ ^ self ].
	^ aBlock value
]
