Class {
	#name : 'SpWindowSimulateOpenModalTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpWindowSimulateOpenModalTest >> testSimulateSimpleOpenModal [
	| dialog presenter |


	presenter := SpTextInputFieldPresenter new.
	dialog := presenter asModalWindow.


	self deny: dialog isOk.
	self assert: presenter text isEmpty.
	
	SpWindowSimulateOpenModal 
		value: [ :aDialogPresenter | 
			aDialogPresenter presenter text: 'SIMULATED'. 
			aDialogPresenter beOk ]
		during: [
			dialog open ].
			
	self assert: dialog isOk.
	self assert: presenter text equals: 'SIMULATED'
]
