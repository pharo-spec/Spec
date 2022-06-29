"
A proxy to enable output ports to be modified by the emisor.
In general, transmission transformations work perfectly fine to transform contents, but they have the disadvantage of they need to be set in the moment of plug them, in the place of the plug.

For example: 

```
aPresenter transmitTo: otherPresenter transform: [ aTransformation ]
```

But... sometimes you want to transform the output in the presenter that will emit itself.
This is the case for example when you want to write inspection presenters to be used on the Pharo inspector.
While you can write your own presenter (for example, extending `StInspection` and redefining your own activation), you can also use this proxy to trap and modify the output.

This example will show how it works: 

```
Collection>>inspectionProxiedItems: aBuilder
	<inspectorPresentationOrder: 1 title: 'Proxied Items'> 
	
	^ SpOutputPortProxy new 
		presenter: (aBuilder newTable		
			addColumn: (SpIndexTableColumn new 
				title: 'Index';
				beNotExpandable;
				yourself);
			addColumn: (SpStringTableColumn new  
				title: 'Value'; 
				evaluated: [ :each | each threeDigitName ];
				yourself);
			items: self asOrderedCollection;
			yourself);
		transform: #outputActivationPort with: [ :aValue | aValue asPoint ];
		yourself
```
"
Class {
	#name : #SpOutputPortProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'presenter',
		'transform'
	],
	#category : #'Spec2-Transmission-Proxy'
}

{ #category : #'instance creation' }
SpOutputPortProxy class >> on: aPresenter [

	^ self new presenter: aPresenter
]

{ #category : #'reflective operations' }
SpOutputPortProxy >> doesNotUnderstand: aMessage [
	| result |
	
	result := aMessage sendTo: presenter.
	transform 
		at: aMessage selector
		ifPresent: [ :aBlock | result transform: aBlock ]. 
	
	^ result
]

{ #category : #initialization }
SpOutputPortProxy >> initialize [

	transform := IdentityDictionary new
]

{ #category : #accessing }
SpOutputPortProxy >> presenter: aPresenter [

	presenter := aPresenter
]

{ #category : #accessing }
SpOutputPortProxy >> transform: outputSelector with: aBlock [

	transform 
		at: outputSelector
		put: aBlock
]

{ #category : #accessing }
SpOutputPortProxy >> yourself [
]
