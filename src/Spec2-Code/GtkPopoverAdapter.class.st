Class {
	#name : #GtkPopoverAdapter,
	#superclass : #GtkAdapter,
	#category : #'Spec2-Code'
}

{ #category : #building }
GtkPopoverAdapter >> addModelTo: gtkPopover [

	gtkPopover add: (GtkLabel newLabel: 'Test') show"self presenterWidget show".
	
	self presenter whenPresenterChangedDo: [
		gtkPopover 
			removeAll;
			add: self presenterWidget show ] 
]

{ #category : #accessing }
GtkPopoverAdapter >> popupPointingTo: aRectangle [

	self widgetDo: [ :w | 
		w 
			setPointingTo: aRectangle asGdkRectangle;
			showAll ]
]

{ #category : #building }
GtkPopoverAdapter >> presenterWidget [

	^ self presenter presenter buildWithSpec
]

{ #category : #building }
GtkPopoverAdapter >> widgetClass [

	^ GtkPopover
]
