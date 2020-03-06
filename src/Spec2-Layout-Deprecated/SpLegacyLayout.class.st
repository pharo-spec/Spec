Class {
	#name : #SpLegacyLayout,
	#superclass : #Object,
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #deprecation }
SpLegacyLayout class >> isDeprecated [
	"Layouts from Spec 1 will be removed in Pharo 9 because the implementation is not good. Please use the new SpecExecutableLayout subclasses instead"

	^ true
]

{ #category : #'Spec2-Deprecated' }
SpLegacyLayout >> buildAdapterFor: aPresenter bindings: adapterBindings [
	"Provides polymorphism with executable layouts."

	^ SpInterpreter 
		interpretASpec: self 
		presenter: aPresenter
]

{ #category : #'Spec2-Deprecated' }
SpLegacyLayout >> isSpLayout [

	^ true
]
