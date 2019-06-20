Class {
	#name : #SpMockDynamicPresenter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'list',
		'label'
	],
	#category : #'Spec-BackendTests-Layout'
}

{ #category : #specs }
SpMockDynamicPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #list;
		add: #label;
		yourself
]

{ #category : #'instance creation' }
SpMockDynamicPresenter class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #'instance creation' }
SpMockDynamicPresenter class >> openWithRebuildBeforeOpening [
	<script>
	^ self new
		selectFirstElement;
		openWithSpec
]

{ #category : #initialization }
SpMockDynamicPresenter >> initializePresenter [
	list
		whenSelectionChangedDo: [ :sel | 
			label := self newLabel.
			label label: sel selectedItem asString.
			self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #initialization }
SpMockDynamicPresenter >> initializeWidgets [
	list := self newList.
	label := self newLabel.
	
	list items: #(1 2 3)
]

{ #category : #accessing }
SpMockDynamicPresenter >> label [
	^ label
]

{ #category : #action }
SpMockDynamicPresenter >> selectFirstElement [
	list selectIndex: 1
]
