"
I am a package part of the Spec 2 project.

Spec is a framework in Pharo for describing user interfaces. It allows for the construction of a wide variety of UIs; from small windows with a few but- tons up to complex tools like a debugger. Indeed, multiple tools in Pharo are written in Spec, e.g., Iceberg, Change Sorter, Critics Browser, and the Pharo debugger.

I am implementing the spec layer between presenters and the morphic widgets. I will be used when the morphic backend of Spec is selected to build the Morphic widgets during the GUI creation.
"
Class {
	#name : 'ManifestSpec2AdaptersMorphic',
	#superclass : 'PackageManifest',
	#category : 'Spec2-Adapters-Morphic-Manifest',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestSpec2AdaptersMorphic class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpMorphicButtonBarAdapter #addModelTo: #false)) #'2020-11-13T23:10:31.921402+01:00') )
]

{ #category : 'code-critics' }
ManifestSpec2AdaptersMorphic class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpMorphicDialogWindowAdapter #buildButtonBar #false)) #'2020-11-13T22:08:25.752583+01:00') #(#(#RGMethodDefinition #(#SpMorphicButtonBarAdapter #addModelTo: #false)) #'2020-11-13T23:10:24.35015+01:00') )
]

{ #category : 'code-critics' }
ManifestSpec2AdaptersMorphic class >> ruleGTExampleNotDefinedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SpAbstractMorphicAdapter)) #'2016-07-01T15:56:13.367433+02:00') )
]

{ #category : 'code-critics' }
ManifestSpec2AdaptersMorphic class >> ruleRBOverridesDeprecatedMethodRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpMorphicMenuItemAdapter #name #false)) #'2016-07-01T15:56:13.381999+02:00') )
]

{ #category : 'code-critics' }
ManifestSpec2AdaptersMorphic class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpMorphicTextAdapter #setWrapWord:to: #false)) #'2020-11-13T22:40:20.610215+01:00') )
]
