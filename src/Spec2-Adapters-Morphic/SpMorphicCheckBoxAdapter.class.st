"
I am an adapter to ease the bridge a CheckBoxPresenter and a CheckboxMorph
"
Class {
	#name : 'SpMorphicCheckBoxAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicCheckBoxAdapter >> buildWidget [

	| checkButton |
	checkButton := CheckboxMorph
						on: self 
						selected: #state
						changeSelected: #state:.
	checkButton 
			label: self getLabelText; 
			beCheckbox;
			hResizing: #spaceFill; 
			vResizing: #shrinkWrap; 
			setBalloonText: self getHelpText;
			getEnabledSelector: #enabled;
			dragEnabled: self dragEnabled;
			dropEnabled: self dropEnabled;	
			labelClickable: self labelClickable.
			
	self presenter whenLabelChangedDo: [ :newLabel | checkButton label: (newLabel ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]) ].
	self presenter whenChangedDo: [ checkButton updateSelection ].
	^ checkButton
]

{ #category : 'emulating' }
SpMorphicCheckBoxAdapter >> clicked [
	
	widget toggleSelected
]

{ #category : 'private' }
SpMorphicCheckBoxAdapter >> getHelpText [

	^ self presenter help ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : 'private' }
SpMorphicCheckBoxAdapter >> getLabelText [

	^ self presenter label ifNotNil: [ :aString | aString localizedForPresenter: self presenter ]
]

{ #category : 'accessing' }
SpMorphicCheckBoxAdapter >> helpText [
	
	^ widget balloonText
]

{ #category : 'widget API' }
SpMorphicCheckBoxAdapter >> label [
	
	^ self getLabelText
]

{ #category : 'widget API' }
SpMorphicCheckBoxAdapter >> labelClickable [
	
	^ self model labelClickable
]

{ #category : 'spec protocol' }
SpMorphicCheckBoxAdapter >> labelOnLeft [

	^ self widgetDo: [ :w | w listDirection: #leftToRight ]
]

{ #category : 'spec protocol' }
SpMorphicCheckBoxAdapter >> labelOnRight [

	^ self widgetDo: [ :w | w listDirection: #rightToLeft ]
]

{ #category : 'widget API' }
SpMorphicCheckBoxAdapter >> state [
	
	^ self presenter state
]

{ #category : 'widget API' }
SpMorphicCheckBoxAdapter >> state: aBoolean [
	
	^ self presenter state: aBoolean
]
