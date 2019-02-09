Class {
	#name : #SpecBoxLayoutShowcase,
	#superclass : #SpecBaseLayoutShowcase,
	#instVars : [
		'direction',
		'homogeneous',
		'spacing',
		'borderWidth',
		'currentLayoutSpec'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #specs }
SpecBoxLayoutShowcase class >> defaultSpec [
	<spec: #default>

	^ SpecBoxLayout newVertical
		beHomogeneous;
		add: #displayedLayout;
		add: (SpecBoxLayout newVertical 
			add: #direction;
			add: #homogeneous;
			add: #spacing;
			add: #borderWidth;
			yourself);
		yourself
]

{ #category : #initialization }
SpecBoxLayoutShowcase >> currentLayoutSpec [

	^ currentLayoutSpec
]

{ #category : #initialization }
SpecBoxLayoutShowcase >> initialize [ 
	
	currentLayoutSpec := SpecBoxLayout newVertical
		add: #presenter1;
		add: #presenter2;
		add: #presenter3;
		add: #presenter4;
		yourself.
		
	super initialize.
]

{ #category : #initialization }
SpecBoxLayoutShowcase >> initializeWidgets [
	
	displayedLayout := self newLayout.
	"controls"
	direction := self newDropList
		items: { 
			'Vertical' -> #newVertical.
			'Horizontal' -> #newHorizontal };
		displayBlock: [ :each | each key ]. 
	
	homogeneous := self newCheckBox
		label: 'be Homogeneous';
		state: currentLayoutSpec isHomogeneous. 
	
	spacing := self newNumberInput
		number: currentLayoutSpec spacing. 
	
	borderWidth := self newNumberInput
		number: currentLayoutSpec borderWidth
	
]

{ #category : #initialization }
SpecBoxLayoutShowcase >> newLayout [

	^ SpecLayoutShowcaseInstance new
		owner: self;
		layout: self currentLayoutSpec;
		yourself
]
