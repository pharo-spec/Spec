"
I contain common actions for inspectors and inspector elements/wrappers
"
Trait {
	#name : #SpTInspectorActions,
	#category : #'Spec-Inspector-Traits'
}

{ #category : #actions }
SpTInspectorActions >> browseSelectedObject [
	self selectedObjectDo: [ :anObject | anObject browse ]
]

{ #category : #actions }
SpTInspectorActions >> browseSelectedObjectClass [
	self selectedObjectDo: [ :anObject | Smalltalk tools browser openOnClass: anObject class ]
]

{ #category : #actions }
SpTInspectorActions >> browseSelectedObjectClassHierarchy [
	self selectedObjectDo: [ :anObject | anObject class browseHierarchy ]
]

{ #category : #actions }
SpTInspectorActions >> exploreSelectedObject [
	self selectedObjectDo: [ :anObject | anObject inspect ].
]

{ #category : #actions }
SpTInspectorActions >> inspectInNewWindow: anObject [

	anObject inspect
]

{ #category : #actions }
SpTInspectorActions >> inspectSelectedObjectInNewWindow [
	self selectedObjectDo: [ :anObject | self inspectInNewWindow: anObject ].
]
