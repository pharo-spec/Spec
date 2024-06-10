Extension { #name : 'SpImageTableColumn' }

{ #category : '*Spec2-ListView' }
SpImageTableColumn >> asColumnViewColumn [

	^ SpColumnViewColumn new
		title: self title;
		expand: (self width isNil and: [ self isExpandable ]);
		width: self width;
		setup: [ :aPresenter | aPresenter newImage ];
		bind: [ :aPresenter :item | aPresenter image: (self readObject: item) ];
		yourself
]
