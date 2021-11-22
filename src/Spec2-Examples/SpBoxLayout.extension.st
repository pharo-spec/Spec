Extension { #name : #SpBoxLayout }

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleAddLast [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		add: 'Enter text' expand: false;
		add: presenter newTextInput expand: false;
		addLast: (presenter newButton label: 'Ok') expand: false;
		yourself).
			
	presenter openWithSpec

]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleBorderWidth [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		borderWidth: 10;
		add: 'Enter text' expand: false;
		add: presenter newTextInput expand: false;
		addLast: (self newLeftToRight
				addLast: (presenter newButton label: 'Ok') expand: false;
				addLast: (presenter newButton label: 'Cancel') expand: false;
				yourself)
			expand: false;
		yourself).
			
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleBorderWidthAndSpacing [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		borderWidth: 10;
		spacing: 10;
		add: 'Enter text' expand: false;
		add: presenter newTextInput expand: false;
		addLast: (self newLeftToRight
				spacing: 10;
				addLast: (presenter newButton label: 'Ok') expand: false;
				addLast: (presenter newButton label: 'Cancel') expand: false;
				yourself)
			expand: false;
		yourself).
			
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleComposite [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		add: 'Enter text' expand: false;
		add: presenter newTextInput expand: false;
		addLast: (self newLeftToRight
				addLast: (presenter newButton label: 'Ok') expand: false;
				addLast: (presenter newButton label: 'Cancel') expand: false;
				yourself)
			expand: false;
		yourself).
			
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleExpand [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		add: presenter newTextInput expand: false;
		add: presenter newText;
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleHAlignCenter [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		hAlignCenter;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleHAlignEnd [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		hAlignEnd;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleHAlignStart [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		hAlignStart;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleVAlignAndHAlign [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		vAlignCenter;
		hAlignCenter;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleVAlignCenter [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		vAlignCenter;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleVAlignEnd [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		vAlignEnd;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpBoxLayout class >> exampleVAlignStart [
	| presenter |

	presenter := SpPresenter new.
	presenter layout: (self newTopToBottom
		vAlignStart;
		add: (presenter newButton
			icon: (presenter application iconNamed: #smallOk);
			label: 'Press me!';
			action: [ presenter application inform: 'Pressed!' ]) 
		yourself).
	presenter openWithSpec
]
