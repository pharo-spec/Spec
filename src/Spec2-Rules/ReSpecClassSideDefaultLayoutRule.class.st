"
I report a composite presenter that defines its layout in a class-side `#defaultLayout`. Its layout should be answered by an instance-side `#defaultLayout`, where the subpresenters can be used directly.

For example, this method is reported:

```
MyPresenter class >> defaultLayout

	^ SpBoxLayout newTopToBottom
		add: #list;
		add: #detail;
		yourself
```

and should be replaced by:

```
MyPresenter >> defaultLayout

	^ SpBoxLayout newTopToBottom
		add: list;
		add: detail;
		yourself
```

## Responsibility:

- Check class-side methods only (`checksMethod`) and report a `#defaultLayout` of a subclass of `SpPresenter`.
- Leave out the whole `SpAbstractWidgetPresenter` hierarchy: widgets have no subpresenters and get their layout from `SpAbstractWidgetPresenter class >> #defaultLayout`, which is kept for backward compatibility (`SpAbstractPresenter >> #defaultLayout` forwards to the class side).
- Explain the fix; I offer no automatic transformation, because many class-side layouts send other messages to the class (`self labelWidth`) that a plain move would break.

## Collaborators: 

- `ReAbstractRule`: the Renraku framework running me on each method and building the critiques.
- `SpPresenter` and `SpAbstractWidgetPresenter`: the hierarchies deciding whether a method is reported.

## Public API and Key Messages

- `basicCheck:` answers whether a compiled method violates the rule.
- `ruleName`, `rationale`, `group` ('Spec') and `severity` ('information') describe me in the Critic Browser.

```
ReSpecClassSideDefaultLayoutRule new basicCheck: SpSliderInputPresenter class >> #defaultLayout.
	""true""
```

### Implementation Points

- The book ""Application Building with Spec 2.0"" presents the class-side layout as the old pattern (chapter ""Reuse and composition at work"", section ""New versus old patterns"").
"
Class {
	#name : 'ReSpecClassSideDefaultLayoutRule',
	#superclass : 'ReAbstractRule',
	#category : 'Spec2-Rules',
	#package : 'Spec2-Rules'
}

{ #category : 'testing - interest' }
ReSpecClassSideDefaultLayoutRule class >> checksMethod [

	^ true
]

{ #category : 'accessing' }
ReSpecClassSideDefaultLayoutRule class >> groupSelector [

	^ #specGroup
]

{ #category : 'accessing' }
ReSpecClassSideDefaultLayoutRule class >> rationale [

	^ 'A composite presenter should answer its layout from an instance-side #defaultLayout, where it can use its subpresenters directly. The class-side #defaultLayout is the old pattern; SpAbstractPresenter>>#defaultLayout only forwards to it for backward compatibility.'
]

{ #category : 'accessing' }
ReSpecClassSideDefaultLayoutRule class >> ruleName [

	^ 'Define defaultLayout on the instance side'
]

{ #category : 'accessing' }
ReSpecClassSideDefaultLayoutRule class >> severity [

	^ 'information'
]

{ #category : 'running' }
ReSpecClassSideDefaultLayoutRule >> basicCheck: aMethod [
	"Answer whether aMethod is a class-side #defaultLayout of a composite presenter, that is a subclass of SpPresenter outside the widget hierarchy."

	| class |
	aMethod isClassSide ifFalse: [ ^ false ].
	class := aMethod methodClass instanceSide.
	((class inheritsFrom: SpPresenter) and: [ (class includesBehavior: SpAbstractWidgetPresenter) not ]) ifFalse: [ ^ false ].
	^ aMethod selector = #defaultLayout
]
