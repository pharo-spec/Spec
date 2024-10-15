"
I am a command decorator adding informations useful when for usage in context of a Spec application.

Basically, I add:
- an #icon (#blank by default)
- a #shortcutKey (optional)
- a #displayStrategy to handle how to show the command if it is not executable on a context (default is to be disabled)
- a #positionStrategy to handle on which side presenter with left and right side I should be (default is left)

"
Class {
	#name : 'SpCommand',
	#superclass : 'CmUICommand',
	#instVars : [
		'buildPresenterBlock',
		'presenter'
	],
	#category : 'Spec2-Commander2-Core',
	#package : 'Spec2-Commander2',
	#tag : 'Core'
}

{ #category : 'converting' }
SpCommand >> asActionButtonPresenter [
	
	^ self asButtonPresenter
		label: nil;
		yourself
]

{ #category : 'converting' }
SpCommand >> asButtonPresenter [
	self flag: #TODO. "Needs to use inform user display strategy when available, no other available strategy can be used in this context. See issue #705"
	self configureAsButton.
	^ self buildPresenter
]

{ #category : 'converting' }
SpCommand >> asToggleButtonPresenter [
	
	self configureAsButtonOfClass: SpToggleButtonPresenter. 
	^ self buildPresenter
]

{ #category : 'initialization' }
SpCommand >> assignUniqueName [
	"we can find a name in case this command has a shortcut (and no name, 
	 whoich would mean it will be *just* a shortcut."
	
	self name ifNotNil: [ ^ self ].
	self hasShortcutKey ifFalse: [ ^ self ].

	self name: self id
]

{ #category : 'presenter building' }
SpCommand >> buildPresenter [
	^ presenter := self buildPresenterBlock value: self
]

{ #category : 'accessing' }
SpCommand >> buildPresenterBlock [
	^ buildPresenterBlock
]

{ #category : 'accessing' }
SpCommand >> buildPresenterBlock: anObject [
	buildPresenterBlock := anObject
]

{ #category : 'presenter building' }
SpCommand >> configureAsButton [

	self configureAsButtonOfClass: SpButtonPresenter
]

{ #category : 'presenter building' }
SpCommand >> configureAsButtonOfClass: aButtonClass [
	self
		buildPresenterBlock: [ :specCommand | 
			aButtonClass new
				label: specCommand name;
				help: specCommand description;
				in: [ :button | 
					specCommand hasIcon
						ifTrue: [ button icon: specCommand icon ] ];
				action: [ specCommand execute ];
				enabled: specCommand canBeExecuted;
				yourself ]
]

{ #category : 'presenter building' }
SpCommand >> configureAsToolBarToggleButton [

	self configureAsButtonOfClass: SpToolbarToggleButtonPresenter
]

{ #category : 'presenter building' }
SpCommand >> configureAsToolbarButton [
	self configureAsButtonOfClass: SpToolbarButtonPresenter
]

{ #category : 'displaying' }
SpCommand >> displayIn: aMenuGroupOrPresenter do: aBlock [

	self displayStrategy 
		display: self 
		in: aMenuGroupOrPresenter 
		do: aBlock
]

{ #category : 'accessing' }
SpCommand >> iconProvider [

	^ iconProvider
]

{ #category : 'private' }
SpCommand >> id [

	^ String streamContents: [ :stream |
		| parts name |
		
		name := self name 
			ifNil: [ 
				self shortcutKey
					ifNotNil: [ 'shortcut ', (KMShortcutPrinter toString: self shortcutKey) ]
					ifNil: [ 'unknown' ] ].
		parts := name substrings.
		stream << parts first asLowercase.
		parts allButFirstDo: [ :each | stream << each capitalized ] ]
]

{ #category : 'initialization' }
SpCommand >> initialize [

	super initialize.
	self configureAsToolbarButton
]

{ #category : 'accessing' }
SpCommand >> innerCommand [
	| innerCommand |

	innerCommand := self decoratedCommand.
	[ innerCommand isKindOf: CmCommandDecorator ]
	whileTrue: [ innerCommand := innerCommand decoratedCommand ].

	^ innerCommand
]

{ #category : 'testing' }
SpCommand >> isEnabled [

	^ self canBeExecuted
]

{ #category : 'testing' }
SpCommand >> isVisible [

	^ true
]

{ #category : 'accessing' }
SpCommand >> presenter [
	^ presenter
]

{ #category : 'updating' }
SpCommand >> updateEnableStatus [

 	self presenter ifNil: [ ^ self ].   
	self presenter enabled: self canBeExecuted
]
