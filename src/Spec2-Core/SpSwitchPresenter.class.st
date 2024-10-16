"
A Checkbox Button that can be activated/deactivated.

"
Class {
	#name : 'SpSwitchPresenter',
	#superclass : 'SpAbstractFormButtonPresenter',
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'specs' }
SpSwitchPresenter class >> adapterName [

	^ #SwitchAdapter
]

{ #category : 'documentation' }
SpSwitchPresenter class >> documentFactoryMethodSelector [

	^ #newSwitch
]

{ #category : 'specs' }
SpSwitchPresenter class >> title [

	^ 'Switch Button'
]

{ #category : 'api' }
SpSwitchPresenter >> label: aString [

	self error: 'Switches can''t have labels'
]
