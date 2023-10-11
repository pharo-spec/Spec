"
I am a layout used for AbstractWidgetPresenters. I will manage all presenter that need to be adapted via a spec adapter for a specific binding.

Examples
--------------------

	SpAbstractWidgetLayout for: #ListAdapter
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	adapterName:		<aSymbol>		Key to use in order to find the real adapter of a presenter for a specific binding.

"
Class {
	#name : 'SpAbstractWidgetLayout',
	#superclass : 'Object',
	#instVars : [
		'adapterName'
	],
	#category : 'Spec2-Layout-Base',
	#package : 'Spec2-Layout',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SpAbstractWidgetLayout class >> for: aSymbol [
	^ self new
		adapterName: aSymbol;
		yourself
]

{ #category : 'building' }
SpAbstractWidgetLayout >> adapt: aPresenter bindings: adapterBindings [
	| adapter oldAdapter |
	adapter := self adapterFor: aPresenter bindings: adapterBindings.
	oldAdapter := aPresenter adapter. 
	adapter adapt: aPresenter.
	oldAdapter ifNotNil: [ :anAdapter | anAdapter unsubscribe ].
	^ adapter
]

{ #category : 'building' }
SpAbstractWidgetLayout >> adapterFor: aPresenter bindings: adapterBindings [
	^ self class environment
		at: (adapterBindings translateSymbol: self adapterName)
		ifPresent: [ :class | class owner: aPresenter ]
		ifAbsent: [ self error: 'No binding for ' , self adapterName , ' found.' ]
]

{ #category : 'accessing' }
SpAbstractWidgetLayout >> adapterName [
	^ adapterName
]

{ #category : 'accessing' }
SpAbstractWidgetLayout >> adapterName: anObject [
	adapterName := anObject
]

{ #category : 'accessing' }
SpAbstractWidgetLayout >> allPresenters [
	
	^ #()
]

{ #category : 'accessing' }
SpAbstractWidgetLayout >> asSpLayout [
	^ self
]

{ #category : 'building' }
SpAbstractWidgetLayout >> buildAdapterFor: aPresenter bindings: adapterBindings [
	"In case we are building an adapter, we need to get the actual adapter class for a specific binding and make it adapt the presenter."

	^ aPresenter needRebuild
		ifTrue: [ self adapt: aPresenter bindings: adapterBindings ]
		ifFalse: [ 
			aPresenter needRebuild: true.
			aPresenter adapter
				ifNil: [ self adapt: aPresenter bindings: adapterBindings ]
				ifNotNil: [ :adapter | 
					adapter isRedrawable ifTrue: [ adapter removeSubWidgets ].
					adapter ] ]
]
