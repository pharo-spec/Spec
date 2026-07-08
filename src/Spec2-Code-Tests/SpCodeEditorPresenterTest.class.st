Class {
	#name : 'SpCodeEditorPresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Code-Tests',
	#package : 'Spec2-Code-Tests'
}

{ #category : 'accessing' }
SpCodeEditorPresenterTest >> adapter [

	^ presenter codePresenter adapter
]

{ #category : 'accessing' }
SpCodeEditorPresenterTest >> classToTest [

	^ SpCodeEditorPresenter
]

{ #category : 'private' }
SpCodeEditorPresenterTest >> codePresenterAdapter [

	^ presenter codePresenter adapter
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testMarkConflictAndUnmarkConflict [

	self openInstance.

	self deny: presenter isConflict.
	self deny: presenter conflictPresenter isVisible.

	presenter markConflict.
	self assert: presenter isConflict.
	self assert: presenter conflictPresenter isVisible.

	presenter unmarkConflict.
	self deny: presenter isConflict.
	self deny: presenter conflictPresenter isVisible
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testMarkDirtyAndUnmarkDirty [

	self openInstance.

	self deny: presenter isDirty.
	self deny: presenter dirtyPresenter isVisible.

	presenter markDirty.
	self assert: presenter isDirty.
	self assert: presenter dirtyPresenter isVisible.

	presenter unmarkDirty.
	self deny: presenter isDirty.
	self deny: presenter dirtyPresenter isVisible
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testTextResetsDirtyAndConflictMarks [

	self openInstance.
	presenter markDirty.
	presenter markConflict.

	presenter text: 'updated'.

	self deny: presenter isDirty.
	self deny: presenter isConflict.
	self deny: presenter dirtyPresenter isVisible.
	self deny: presenter conflictPresenter isVisible
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testTypingMarksDirty [

	self openInstance.

	presenter codePresenter typeByChar: 'abc'.

	self assert: presenter isDirty.
	self assert: presenter dirtyPresenter isVisible.
	self deny: presenter isConflict
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testWhenResetDoResetsDirtyAndConflictStatus [

	| reset |
	reset := false.
	presenter whenResetDo: [ reset := true ].
	self openInstance.
	presenter markDirty.
	presenter markConflict.

	self codePresenterAdapter
		keyDown: $l
		shift: false
		meta: true
		control: false
		option: false.

	self assert: reset.
	self deny: presenter isDirty.
	self deny: presenter isConflict.
	self deny: presenter dirtyPresenter isVisible.
	self deny: presenter conflictPresenter isVisible
]

{ #category : 'tests' }
SpCodeEditorPresenterTest >> testWhenSubmitDoResetsDirtyAndConflictStatus [

	| submitted |
	submitted := nil.
	presenter whenSubmitDo: [ :text | submitted := text ].
	self openInstance.
	presenter text: 'abc'.
	presenter markDirty.
	presenter markConflict.

	self codePresenterAdapter
		keyDown: $s
		shift: false
		meta: true
		control: false
		option: false.

	self assert: submitted equals: 'abc'.
	self deny: presenter isDirty.
	self deny: presenter isConflict.
	self deny: presenter dirtyPresenter isVisible.
	self deny: presenter conflictPresenter isVisible
]
