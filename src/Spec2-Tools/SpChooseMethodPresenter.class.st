"
I am an UI used to select a method of the system.
 
I'll display the list of packages of the system, the classes of the selected package and the methods of the selected class, the protocols of selectedClass. 

The user can configure me with an action to execute when the user does the selection. The action will take my instance as parameter to get the package/class/method/protocols selected.

###Public API and Key Messages

- `#openOnAccept:`  This method will open me in a modal and execute the block as parameter when the user accept.

###Examples

```
	(self 
		openOnAccept: [ :chooseMethodPresenter | chooseMethodPresenter selectedMethod browse ])
		withWindowDo: [ :w | w title: 'Select a method example' ]
```
 
### Internal Representation and Key Implementation Points.

Instance Variables
-	packageList:						<aListPresenter>	A list of the packages of the system.
-	classList:						<aListPresenter>	A list of the classes in the selected package.
-	methodList:						<aListPresenter>	A list of the methods in the selected class.
-	protocolList:               <aListPresenter>  A list of the protocols in the selected class. 
-	radioButtonClassSide:			<aRadioButton>		A radio button to select the class side. 
-	radioButtonInstanceSide:		<aRadioButton>		A radio button to select the instance side.

"
Class {
	#name : #SpChooseMethodPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packageList',
		'classList',
		'methodList',
		'radioButtonInstanceSide',
		'radioButtonClassSide',
		'protocolList'
	],
	#category : #'Spec2-Tools-ChooseMethod'
}

{ #category : #specs }
SpChooseMethodPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		position: 25 percent;
		add: #packageList;
		add:
			(SpPanedLayout newHorizontal
				position: 25 percent;
				add: #classList;
				add:
					(SpPanedLayout newHorizontal
						position: 40 percent;
						add: #protocolList;
						add:
							(SpBoxLayout newVertical
								add: #methodList;
								add:
									(SpBoxLayout newHorizontal
										add: #radioButtonInstanceSide;
										add: #radioButtonClassSide;
										yourself)
									withConstraints: [ :contraint | contraint height: 20 ];
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #examples }
SpChooseMethodPresenter class >> exampleMethodChooser [
	<example>

	(self openOnAccept: [ :chooseMethodPresenter | chooseMethodPresenter selectedMethod browse ]) 
				withWindowDo: [ :w | w title: 'Select a method example' ]
]

{ #category : #examples }
SpChooseMethodPresenter class >> exampleNavigationSystem [
	<example>
	
	| presenter |
	presenter := self new.
	presenter openWithSpec extent: 900 @ 400.
	^ presenter
]

{ #category : #'instance creation' }
SpChooseMethodPresenter class >> openOnAccept: aBlock [
	| instance |
	instance := self new.
	instance openModalWithSpec.
	instance withWindowDo: [ :w | w okAction: [ :dialog | aBlock cull: instance cull: dialog ] ].
	^ instance
]

{ #category : #accessing }
SpChooseMethodPresenter >> classList [

	^ classList
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> classListAction [

	classList
		transmitTo: methodList
		transform: [ :selectedClass | 
			selectedClass
				ifNotNil: [ self methodsFromClass: selectedClass ]
				ifNil: [ #() ] ]
		postTransmission: [ :destination | destination selectIndex: 1 ].

	classList
		transmitTo: protocolList
		transform: [ :selectedClass |
			selectedClass
				ifNotNil: [ self isInstanceSideSelected
						ifTrue:
							[ selectedClass organization allProtocols as: OrderedCollection ]
						ifFalse:
							[ selectedClass class organization allProtocols as: OrderedCollection ] ] 
					ifNil: [ #()]]
		postTransmission: [ :protcolList | 
			protocolList
				selectIndex: ((protcolList items collect: [ :each | each name ]) indexOf: '-- all --') ]
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> connectPresenters [

	self 
		packageListAction;
		classListAction;
		protocolListAction;
		radioButtonsAction.
		
	packageList selectIndex: 1
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> fillWith: aClass [

	methodList items: aClass methods.
	^ protocolList items: (aClass protocols 
		collect: [ :eachSymbol | aClass organization protocolOrganizer protocolNamed: eachSymbol ])
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> initClassList [

	classList := self newList.
	classList
		sortingBlock: #name ascending;
		displayIcon: [ :item | self iconNamed: item systemIconName ]
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> initMethodList [

	methodList := self newList.
	methodList
		sortingBlock: #name ascending;
		display: #selector
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> initPackageList [

	packageList := self newList.
	packageList
		items: RPackageOrganizer default packages;
		display: #name;
		sortingBlock: #name ascending;
		displayIcon: [ :item | self iconNamed: #package ]
	 
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> initProtocolList [

	protocolList := self newList.
	protocolList
		display: #name;
		sortingBlock: #name ascending
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> initRadioButtons [

	radioButtonClassSide := self newRadioButton.
	radioButtonInstanceSide := self newRadioButton.
	
	radioButtonClassSide 
		label: 'class side'.
		
	radioButtonInstanceSide
		label: 'instance side';
		state: true;
		associatedRadioButtons: {radioButtonClassSide}.

]

{ #category : #initialization }
SpChooseMethodPresenter >> initializeDialogWindow: aDialog [

	super initializeDialogWindow: aDialog.
	aDialog
		initialExtent: 600 @ 400;
		title: 'Select a method';
		closeOnBackdropClick: false
]

{ #category : #initialization }
SpChooseMethodPresenter >> initializePresenters [

	self 
		initPackageList;
		initClassList;
		initProtocolList;
		initMethodList;
		initRadioButtons.
				
	self focusOrder
		add: packageList;
		add: classList;
		add: protocolList;
		add: methodList
]

{ #category : #'private - testing' }
SpChooseMethodPresenter >> isInstanceSideSelected [

	^ radioButtonInstanceSide state
]

{ #category : #accessing }
SpChooseMethodPresenter >> methodList [

	^ methodList
]

{ #category : #'private - utilities' }
SpChooseMethodPresenter >> methodNamed: methodSelector [

	^ (self isInstanceSideSelected
		   ifTrue: [ self selectedClass ]
		   ifFalse: [ self selectedClass class ]) methodNamed: methodSelector
]

{ #category : #'private - utilities' }
SpChooseMethodPresenter >> methodsFromClass: aClass [

	^ (self isInstanceSideSelected
		   ifTrue: [ aClass ]
		   ifFalse: [ aClass class ]) methods asOrderedCollection
]

{ #category : #accessing }
SpChooseMethodPresenter >> packageList [

	^ packageList
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> packageListAction [
	packageList
		transmitTo: classList
		transform: [ :selectedPackage | 
			selectedPackage
				ifNil: [ #() ]
				ifNotNil: [ selectedPackage classes asOrderedCollection ] ]
		postTransmission: [ classList selectIndex: 1 ]
]

{ #category : #accessing }
SpChooseMethodPresenter >> protocolList [

	^ protocolList
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> protocolListAction [
	protocolList
		transmitTo: methodList
		transform: [ :selectedProtocol | 
			selectedProtocol
				ifNotNil: [ (selectedProtocol methodSelectors
						collect: [ :methodSelector | self methodNamed: methodSelector ])
						asOrderedCollection ]
				ifNil: [ #() ] ]
		postTransmission: [ :methodPresenter | methodPresenter selectIndex: 1 ]
]

{ #category : #accessing }
SpChooseMethodPresenter >> radioButtonClassSide [

	^ radioButtonClassSide
]

{ #category : #accessing }
SpChooseMethodPresenter >> radioButtonInstanceSide [

	^ radioButtonInstanceSide
]

{ #category : #'private - initialization' }
SpChooseMethodPresenter >> radioButtonsAction [
	radioButtonClassSide whenActivatedDo: [ self fillWith: self selectedClass class ].
	radioButtonInstanceSide whenActivatedDo: [ self fillWith: self selectedClass ]
]

{ #category : #accessing }
SpChooseMethodPresenter >> selectedClass [

	^ classList selection selectedItem
]

{ #category : #accessing }
SpChooseMethodPresenter >> selectedMethod [

	^ methodList selectedItem
]

{ #category : #accessing }
SpChooseMethodPresenter >> selectedPackage [

	^ packageList selectedItem
]

{ #category : #accessing }
SpChooseMethodPresenter >> selectedProtocol [

	^ protocolList selection selectedItem
]
