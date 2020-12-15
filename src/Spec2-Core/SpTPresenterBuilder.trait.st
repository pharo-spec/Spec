"
A builder to define presenters through method factory pattern. 
This allow users to compose presenters without needed to have hardcoded the name of them (which could or not change/be present/etc.)
"
Trait {
	#name : #SpTPresenterBuilder,
	#category : #'Spec2-Core-Base'
}

{ #category : #'instance creation' }
SpTPresenterBuilder >> instantiate: aPresenterClass [
	"Instantiate a SpPresenter subclass and set its instance owner"
	^ aPresenterClass owner: self
]

{ #category : #'instance creation' }
SpTPresenterBuilder >> instantiate: aPresenterClass on: aModel [
	"Instantiate a SpPresenter subclass and set its instance owner and model"
	^ aPresenterClass owner: self on: aModel
]

{ #category : #widgets }
SpTPresenterBuilder >> newActionBar [

	^ self instantiate: SpActionBarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newAthens [

	^ self instantiate: SpAthensPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newButton [
	^ self instantiate: SpButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newButtonBar [

	^ self instantiate: SpButtonBarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newCheckBox [
	^ self instantiate: SpCheckBoxPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newComponentList [
	^ self instantiate: SpComponentListPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newDiff [
	^ self instantiate: SpDiffPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newDropList [
	^ self instantiate: SpDropListPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newDynamicPresentersListIn: accessorSymbol usingBuilder: aDynamicPresentersListBuilder [
	|mutatorSymbol newDynamicPresenter |
	mutatorSymbol := (accessorSymbol , ':') asSymbol.
	(self perform: accessorSymbol)
		ifNotNil: [ :dynamicPresenter | dynamicPresenter owner: nil ].
	newDynamicPresenter := aDynamicPresentersListBuilder build.
	
	self perform: mutatorSymbol with: newDynamicPresenter.
	
	newDynamicPresenter owner: self.
	
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #widgets }
SpTPresenterBuilder >> newFilteringList [

	^ self instantiate: SpFilteringListPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newLabel [
	^ self instantiate: SpLabelPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newList [
	^ self instantiate: SpListPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newMenu [
	^ self instantiate: SpMenuPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newMenuBar [
	^ self instantiate: SpMenuBarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newMenuButton [

	^ self instantiate: SpMenuButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newNotebook [

	^ self instantiate: SpNotebookPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newNotebookPage [

	self flag: #TODO. "NotebookPage needs to be a Presenter?"
	^ SpNotebookPage new
]

{ #category : #widgets }
SpTPresenterBuilder >> newNullPresenter [
	^ self instantiate: SpNullPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newNumberInput [
	^ self instantiate: SpNumberInputFieldPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newPopover [

	^ self instantiate: SpPopoverPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newPresenterSelector [

	^ self instantiate: SpPresenterSelectorPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newProgressBar [
	^ self instantiate: SpProgressBarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newRadioButton [
	^ self instantiate: SpRadioButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newRichText [

	^ self instantiate: SpRichTextPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newSearchInput [

	^ self instantiate: SpSearchInputFieldPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newSlider [
	^ self instantiate: SpSliderPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newStatusBar [

	^ self instantiate: SpStatusBarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newTable [

	^ self instantiate: SpTablePresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newText [
	^ self instantiate: SpTextPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newTextInput [
	^ self instantiate: SpTextInputFieldPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToggleButton [

	^ self instantiate: SpToggleButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToolbar [

	^ self instantiate: SpToolbarPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToolbarButton [

	^ self instantiate: SpToolbarButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToolbarMenuButton [

	^ self instantiate: SpToolbarMenuButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToolbarPopoverButton [

	^ self instantiate: SpToolbarPopoverButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newToolbarToggleButton [

	^ self instantiate: SpToolbarToggleButtonPresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newTree [

	^ self instantiate: SpTreePresenter
]

{ #category : #widgets }
SpTPresenterBuilder >> newTreeTable [

	^ self instantiate: SpTreeTablePresenter
]
