Extension { #name : 'SpecGtkBackend' }

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> dropListClass [

	^ SpDropDownPresenter
]

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> listClass [

	^ SpEasyListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> switchClass [

	^ SpSwitchPresenter
]

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> tableClass [

	^ SpEasyColumnViewPresenter
]

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> treeClass [

	^ SpEasyTreeListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpecGtkBackend >> treeTableClass [

	^ SpEasyTreeColumnViewPresenter
]
