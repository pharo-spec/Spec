Class {
	#name : #SpMorphicMenuButtonAdapter,
	#superclass : #SpMorphicButtonAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #'widget API' }
SpMorphicMenuButtonAdapter >> action [ 

	self showSubMenu: self presenter menu.
	self widget ifNotNil: [ :m | m takeKeyboardFocus ].
	self model performAction
]

{ #category : #factory }
SpMorphicMenuButtonAdapter >> defaultIcon [
		
	^ self application iconNamed: #arrowDown
]

{ #category : #accessing }
SpMorphicMenuButtonAdapter >> icon [

	^ self presenter icon ifNil: [ self defaultIcon ]
]

{ #category : #factory }
SpMorphicMenuButtonAdapter >> newButton [

	^ PluggableButtonMorph
		on: self 
		getState: #state 
		action:  #action 
		label: #label 
		icon: #icon
		menu: nil
]
