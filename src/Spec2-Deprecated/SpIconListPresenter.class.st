"
An IconListPresenter is a spec presenter for icon list.
See AbstractWidgetPresenter

self example

You can also have a look at ExampleListPresenter >> exampleIconList for another example.

I provide the following variables icons and its accessors, it is a block that convert an item in the icon to display near the item.

todo
- getIconFor:
"
Class {
	#name : 'SpIconListPresenter',
	#superclass : 'SpListPresenter',
	#category : 'Spec2-Deprecated-Replaced',
	#package : 'Spec2-Deprecated',
	#tag : 'Replaced'
}

{ #category : '*Spec2-Deprecated' }
SpIconListPresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : '*Spec2-Deprecated' }
SpIconListPresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : '*Spec2-Deprecated' }
SpIconListPresenter class >> isDeprecated [
	^ true
]

{ #category : '*Spec2-Deprecated' }
SpIconListPresenter class >> isDeprecated [
	^ true
]
