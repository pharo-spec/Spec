Extension { #name : 'SpTableColumn' }

{ #category : '*Spec2-ListView' }
SpTableColumn >> asColumnViewColumn [

	^ SpColumnViewColumn new
		title: self title;
		expand: (self width isNil and: [ self isExpandable ]);
		width: self width;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :item | aPresenter label: (self readObject: item) asString ];
		yourself
]
