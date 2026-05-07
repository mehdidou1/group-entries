Class {
	#name : 'NECPrefixGroupEntry',
	#superclass : 'CoEntry',
	#instVars : [
		'children',
		'prefix'
	],
	#category : 'Group-Entries',
	#package : 'Group-Entries'
}

{ #category : 'instance creation' }
NECPrefixGroupEntry class >> prefix: aString children: aCollection [

	^ self new
		  prefix: aString;
		  children: aCollection asOrderedCollection;
		  contents: aString;
		  displayedContents: aString , ' ▸';
		  yourself
]

{ #category : 'actions' }
NECPrefixGroupEntry >> activateOn: aCompletionContext [

	aCompletionContext openGroup: self
]

{ #category : 'actions' }
NECPrefixGroupEntry >> browse [

	^ false
]

{ #category : 'actions' }
NECPrefixGroupEntry >> children [

	^ children
]

{ #category : 'actions' }
NECPrefixGroupEntry >> children: aCollection [

	children := aCollection
]

{ #category : 'actions' }
NECPrefixGroupEntry >> createDescription [

	| preview limit |
	limit := children size min: 10.

	preview := String streamContents: [ :stream |
		1 to: limit do: [ :i |
			stream
				nextPutAll: (children at: i) displayedContents;
				cr ] ].

	^ CoEntryDescription
		label: 'group'
		title: prefix , ' (' , children size asString , ')'
		description: preview
]

{ #category : 'actions' }
NECPrefixGroupEntry >> hightlightSymbol [

	^ children
		ifEmpty: [ nil ]
		ifNotEmpty: [ children first hightlightSymbol ]
]

{ #category : 'actions' }
NECPrefixGroupEntry >> isGroupEntry [

	^ true
]

{ #category : 'actions' }
NECPrefixGroupEntry >> prefix [

	^ prefix
]

{ #category : 'actions' }
NECPrefixGroupEntry >> prefix: aString [

	prefix := aString
]

{ #category : 'actions' }
NECPrefixGroupEntry >> rawLabel [

	^ 'group'
]
