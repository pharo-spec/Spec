"
I'm the adapter used to bridge a ToggleButton and its morphic representation.
"
Class {
	#name : 'SpMorphicToggleButtonAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#instVars : [
		'styleName'
	],
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicToggleButtonAdapter >> buildWidget [
	| checkButton |

	checkButton := PluggableToggleButtonMorph
		on: self
		getState: #state
		action: #toggleAction:
		label: #label
 		menu: nil.

	checkButton
		icon: self icon;
		label: self getLabelText;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		setBalloonText: self getHelpText;
		getEnabledSelector: #enabled;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled.

	self presenter whenLabelChangedDo: [ :newLabel | 
		checkButton label: (newLabel ifNotNil: [ :aString | 
			aString localizedForPresenter: self presenter ]) ].
	self presenter whenIconChangedDo: [ checkButton icon: self icon ].
	self presenter whenChangedDo: [ self buttonChanged ].

	^ checkButton
]

{ #category : 'private' }
SpMorphicToggleButtonAdapter >> buttonChanged [
	| state associated |
	
	state := self state.
	associated := self presenter associatedToggleButtons.	
	state ifTrue: [ 
		associated do: [ :each | each state: false ] ].
	
	widget pressed: state
]

{ #category : 'emulating' }
SpMorphicToggleButtonAdapter >> clicked [
	
	widget performAction.
	self model state: widget isPressed
]

{ #category : 'private' }
SpMorphicToggleButtonAdapter >> getHelpText [

	^ self presenter help ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : 'private' }
SpMorphicToggleButtonAdapter >> getLabelText [

	^ self presenter label ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : 'accessing' }
SpMorphicToggleButtonAdapter >> helpText [
	
	^ widget balloonText
]

{ #category : 'widget API' }
SpMorphicToggleButtonAdapter >> icon [
	
	^ self presenter icon
]

{ #category : 'widget API' }
SpMorphicToggleButtonAdapter >> label [
	
	^ self getLabelText
]

{ #category : 'widget API' }
SpMorphicToggleButtonAdapter >> state [
	
	^ self presenter state
]

{ #category : 'widget API' }
SpMorphicToggleButtonAdapter >> state: aBoolean [
	
	^ self presenter state: aBoolean
]

{ #category : 'accessing' }
SpMorphicToggleButtonAdapter >> styleName [

	^ styleName ifNil: [ super styleName ]
]

{ #category : 'accessing' }
SpMorphicToggleButtonAdapter >> styleName: aString [ 

	styleName := aString
]

{ #category : 'events' }
SpMorphicToggleButtonAdapter >> toggleAction: aBoolean [ 
	
	self model state: aBoolean.
	^ self model action cull: aBoolean 
]
