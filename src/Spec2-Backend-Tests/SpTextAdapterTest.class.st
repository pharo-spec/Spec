Class {
	#name : 'SpTextAdapterTest',
	#superclass : 'SpAbstractTextAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTextAdapterTest >> classToTest [

	^ SpTextPresenter
]

{ #category : 'accessing' }
SpTextAdapterTest >> testAddShortcut [
	| handled |

	handled := false.
	presenter 
		addShortcutWith: [ :action | action
			shortcutKey: $x meta; 
			action: [ handled := true ] ].

	self adapter 
		keyDown: $x 
		shift: false 
		meta: true
		control: false
		option: false. 

	self assert: handled
]

{ #category : 'accessing' }
SpTextAdapterTest >> testKeyBindings [
	| handled |

	handled := false.
	presenter 
		bindKeyCombination: $x meta 
		toAction: [ handled := true ].

	self adapter 
		keyDown: $x 
		shift: false 
		meta: true
		control: false
		option: false. 

	self assert: handled
]

{ #category : 'tests' }
SpTextAdapterTest >> testLineAtCursorPosition [

	self openInstance.
	presenter text: 'one
two
three'.
	
	presenter cursorPositionIndex: 5.
	self assert: presenter lineAtCursorPosition equals: 'two'.
	
	presenter cursorPositionIndex: 8.
	self assert: presenter lineAtCursorPosition equals: 'two'.	
	
	presenter cursorPositionIndex: 14.
	self assert: presenter lineAtCursorPosition equals: 'three'.
	
	presenter text: ''.
	presenter cursorPositionIndex: 1.
	self assert: presenter lineAtCursorPosition equals: ''.
	
	
]

{ #category : 'accessing' }
SpTextAdapterTest >> testRightClickShowsMenu [
	| menu |

	presenter contextMenu: (menu := SpMockMenuPresenter new).

	self deny: menu shown.
	self emulateRightClick.
	self assert: menu shown
]

{ #category : 'tests' }
SpTextAdapterTest >> testSettingTextManuallyAffectsTheUndoManager [
	| undoManager |

	self openInstance.
	presenter text: 'one'.

	undoManager := presenter adapter widget textArea editingState undoManager.	
	self deny: undoManager hasNext.
	self assert: undoManager hasPrevious
]

{ #category : 'tests' }
SpTextAdapterTest >> testSettingTextManuallyClearsTheUndoManager [
	| undoManager |

	self openInstance.
	presenter text: 'one'.

	"setting affect the undo manager"
	presenter 
		type: 'two';
		type: 'three'.

	presenter text: 'four'.

	undoManager := presenter adapter widget textArea editingState undoManager.	
	self deny: undoManager hasNext.
	self assert: undoManager hasPrevious.
	self assert: undoManager size equals: 1
]

{ #category : 'tests' }
SpTextAdapterTest >> testTextIsAlwaysString [

	presenter text: 'one'.
	self openInstance.
	
	self assert: (presenter text isKindOf: String)

]

{ #category : 'tests' }
SpTextAdapterTest >> testWithoutUndoRedoHistory [
	| undoManager |

	presenter withoutUndoRedoHistory.
	self openInstance.
	presenter text: 'one'.
	presenter type: 'two'.
	presenter type: 'three'.
	
	undoManager := presenter adapter widget textArea editingState undoManager.	
	self deny: undoManager hasNext.
	self deny: undoManager hasPrevious
]
