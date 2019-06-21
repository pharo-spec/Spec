Extension { #name : #CompiledMethod }

{ #category : #'*Spec-Inspector' }
CompiledMethod class >> additionalInspectorClasses [
	^ super additionalInspectorClasses, { SpEyeMethodEditor }
]

{ #category : #'*Spec-Inspector' }
CompiledMethod class >> inspectorClass [
	^ SpEyeCompiledMethodInspector
]
