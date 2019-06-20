Extension { #name : #SpMorphicListAdapter }

{ #category : #'*Spec-Deprecated80' }
SpMorphicListAdapter >> getSelectionStateFor: anIndex [
	self deprecated: 'This method from the old API will be removed.'.
	^ self model getSelectionStateFor: anIndex
]
