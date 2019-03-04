Extension { #name : #TreePresenter }

{ #category : #'*Spec-Examples' }
TreePresenter class >> example [
	<sampleInstance>
	| m |

	m := self new.
	m openWithSpec.
	
	m roots: #(a b c d).
	m childrenBlock: [:it | it = #c 
		ifTrue: [ {1. 2. 3} ]
		ifFalse: [ {} ]].
	m displayBlock: [:item | item isSymbol
		ifTrue: [ item asUppercase , ' symbol' ]
		ifFalse: [ item printString ]].
	m 
		dragEnabled: true;
		dropEnabled: true;
		wantDropBlock: [ :draggedItem :event :source | 
			draggedItem isTransferable and: [ draggedItem source = m ] ];
		acceptDropBlock: [ :transfer :event :source :receiver | 
			Transcript 
				show: 'Dragged node '; 
				show: transfer passenger content; 
				show: ' to node '; 
				show: receiver content; 
				cr ].
		
	^ m
]

{ #category : #'*Spec-Examples' }
TreePresenter class >> exampleOfAutoRefreshOnExpand [
	"Each time a node is expanded, the computation of the children is made again, instead of being cached as it is usually"

	TreePresenter new
		childrenBlock: [ :number | 
			self logCr: 'Compute children of ', number asString.
			1 to: number ];
		hasChildrenBlock: [ :number | true ];
		roots: (1 to: 10);
		autoRefreshOnExpand: true;
		openWithSpec
]

{ #category : #'*Spec-Examples' }
TreePresenter class >> exampleWithCustomColumnsAndNodes [
	<haltOrBreakpointForTesting>
	| m col1 col2 |

	m := TreePresenter new.
	m roots: #(#a #b #c #d).
	m rootNodeHolder: [ :item | 
		TreeNodePresenter new
			content: item;
			icon: (self iconNamed: #smallConfigurationIcon)
	].
	
	m openWithSpec.
	
	col1 := TreeColumnPresenter new
		displayBlock: [ :node | node content asString ];
		headerLabel: 'Character'.
	col2 := TreeColumnPresenter new
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 1) asString ];
		headerLabel: 'Character +1';
		headerIcon: (self iconNamed: #smallBackIcon).
	
	m
		columns: {col1. col2};
		dragEnabled: true;
		dropEnabled: true;
		acceptDropBlock: [ :transfer :event :source :receiver | self halt ].
		
	col2 
		headerLabel: 'Character +2';
		headerIcon: (self iconNamed: #smallBackIcon);
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 2) asString ].
	
	m rootNodeHolder: [ :item | 
		TreeNodePresenter new
			content: (Character value: (item asString first asciiValue + 5)) asSymbol;
			icon: (self iconNamed: #smallFullscreenIcon)
	].

	col1 headerIcon: (self iconNamed: #nautilusIcon).
]

{ #category : #'*Spec-Examples' }
TreePresenter class >> exampleWithCustomColumnsAndNodesAndChildren [
	<haltOrBreakpointForTesting>

	| m col1 col2 |
	m := TreePresenter new.
	m roots: #(#a #b #c #d).
	m
		rootNodeHolder: [ :item | 
			TreeNodePresenter new
				content: item;
				children: [ (1 to: item asString first asciiValue) collect: [ :e | TreeNodePresenter new content: e ] ];
				icon: (m iconNamed: #smallConfigurationIcon) ].
	m openWithSpec.
	col1 := TreeColumnPresenter new
		displayBlock: [ :node | node content asString ];
		headerAction: [ self halt ].
	col2 := TreeColumnPresenter new
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 1) asString ].
	m
		columns:
			{col1.
			col2};
		dragEnabled: true;
		dropEnabled: true;
		acceptDropBlock: [ :transfer :event :source :receiver | self halt ].
	col2
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 2) asString ]
]

{ #category : #'*Spec-Examples' }
TreePresenter class >> exampleWithNoSpecifiedNodes [
	"self exampleWithNoSpecifiedNodes"

	TreePresenter new
		 roots: (1 to: 5);
		 childrenBlock: [ :item | 1+item to: 5+item ];
		 openWithSpec
]
