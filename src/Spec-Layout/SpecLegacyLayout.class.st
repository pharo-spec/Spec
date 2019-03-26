Class {
	#name : #SpecLegacyLayout,
	#superclass : #Object,
	#category : #'Spec-Layout-Layouts'
}

{ #category : #building }
SpecLegacyLayout >> buildAdapterFor: aPresenter bindings: adapterBindings [
	"Provides polymorphism with executable layouts."

	^ SpecInterpreter 
		interpretASpec: self 
		presenter: aPresenter
]

{ #category : #testing }
SpecLegacyLayout >> isSpecLayout [

	^ true
]
