"
I'm a dynamic variable for presenters on which a bindings (Morphic or other) should be used as default.

Example: 

```
	SpecBindings value: #MorphicAdapterBindings during: [ myPresenter openWithSpec ].
```
"
Class {
	#name : 'SpBindings',
	#superclass : 'DynamicVariable',
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpBindings >> default [
	^ (self class environment at: #SpMorphicAdapterBindings) new
]
