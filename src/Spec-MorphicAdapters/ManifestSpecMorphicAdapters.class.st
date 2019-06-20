"
Morphic specific spec adapters
"
Class {
	#name : #ManifestSpecMorphicAdapters,
	#superclass : #PackageManifest,
	#category : #'Spec-MorphicAdapters-Manifest'
}

{ #category : #'code-critics' }
ManifestSpecMorphicAdapters class >> ruleGTExampleNotDefinedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SpAbstractMorphicAdapter)) #'2016-07-01T15:56:13.367433+02:00') )
]

{ #category : #'code-critics' }
ManifestSpecMorphicAdapters class >> ruleRBOverridesDeprecatedMethodRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpMorphicMenuItemAdapter #name #false)) #'2016-07-01T15:56:13.381999+02:00') )
]
