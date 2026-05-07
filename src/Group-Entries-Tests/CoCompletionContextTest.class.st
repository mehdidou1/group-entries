Class {
	#name : 'CoCompletionContextTest',
	#superclass : 'TestCase',
	#instVars : [
		'completionContext',
		'items'
	],
	#category : 'Group-Entries-Tests',
	#package : 'Group-Entries-Tests'
}

{ #category : 'running' }
CoCompletionContextTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	completionContext := CoCompletionContext new.
	items := OrderedCollection new.
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWCheckBoundaries [
	"hello's size is 5 so it has no prefix, helloW's size is 6"
	completionContext completionToken: 'hello'.
	items
  add: (CoGlobalEntry new contents: 'hello'; yourself);
	add: (CoGlobalEntry new contents: 'helloW'; yourself) .
	self assert: (completionContext buildGroupedEntriesFrom: items ) size equals: 2
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWhenEmptyCollection [
	self assert: (completionContext buildGroupedEntriesFrom: items ) isEmpty 
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWhenEntriesShorterThanPrefixSize [
	completionContext completionToken: 'Hello'.
	items
  add: (CoSelectorEntry new contents: 'foo'; yourself);
  add: (CoSelectorEntry new contents: 'bar'; yourself);
  add: (CoSelectorEntry new contents: 'baz'; yourself).
	self assert: (completionContext buildGroupedEntriesFrom: items ) equals: items 
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWithMixedComponents [
	"Two entries sharing the same prefix, one single entry, and a short entry"
	completionContext completionToken: 'CoASTHeuristics'.
	items
  add: (CoGlobalEntry new contents: 'CoASTHeuristicsResultSetBuilder'; yourself);
	add: (CoGlobalEntry new contents: 'CoASTHeuristicsFetcher'; yourself); 
	add: (CoGlobalEntry new contents: 'CoEntry'; yourself); 
	add: (CoGlobalEntry new contents: 'Co'; yourself) .
	self assert: (completionContext buildGroupedEntriesFrom: items ) size equals: 3 
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWithMultipleLongEntries [
	"With multiple entries sharing the same prefix, it should return a NECPrefixGroupEntry"

	completionContext completionToken: 'CoASTHeuristics'.
	items
		add: (CoGlobalEntry new
				 contents: 'CoASTHeuristicsResultSetBuilder';
				 yourself);
		add: (CoGlobalEntry new
				 contents: 'CoASTHeuristicsFetcher';
				 yourself).
	self assert: (completionContext buildGroupedEntriesFrom: items) size equals: 1.
	self assert: (completionContext buildGroupedEntriesFrom: items) first class equals: CoEntry
]

{ #category : 'testing' }
CoCompletionContextTest >> testBuildGroupedEntriesFromWithSingleLongEntry [
	"With One single entry, it shouldn't return a NECPrefixGroupEntry"
	completionContext completionToken: 'CoASTHeuristics'.
	items
  add: (CoGlobalEntry new contents: 'CoASTHeuristicsResultSetBuilder'; yourself).
	self assert: (completionContext buildGroupedEntriesFrom: items ) equals: items 
]

{ #category : 'testing' }
CoCompletionContextTest >> testGroupingPrefixForWhenCompletionTokenSizeBelowGroupingPrefixSize [
	completionContext completionToken: 'CoAS'.
	
	self assert: (completionContext groupingPrefixFor: 'CoASTHeuristicsFetcher') equals: 'CoAST'
]

{ #category : 'testing' }
CoCompletionContextTest >> testGroupingPrefixForWhenEmptyEntry [
	completionContext completionToken: 'CoASTHeuristics'.
	
	self assert: (completionContext groupingPrefixFor: '') isNil
]

{ #category : 'testing' }
CoCompletionContextTest >> testGroupingPrefixForWhenEntrySizeAbovePrefix [
	completionContext completionToken: 'CoASTHeuristics'.
	
	self assert: (completionContext groupingPrefixFor: 'CoASTHeuristicsFetcher') equals: 'CoASTHeuristics'
]

{ #category : 'testing' }
CoCompletionContextTest >> testGroupingPrefixForWhenTextIsShorterThanPrefixSize [
	completionContext completionToken: 'CoASTHeuristics'.
	
	self assert: (completionContext groupingPrefixFor: 'CoAST') isNil 
]

{ #category : 'testing' }
CoCompletionContextTest >> testGroupingPrefixForWhenTextSizeIsEqualToPrefixSize [
	completionContext completionToken: 'CoASTHeuristics'.
	
	self assert: (completionContext groupingPrefixFor: 'CoASTHeuristics') isNil 
]

{ #category : 'testing' }
CoCompletionContextTest >> testLeaveGroupWhenGroupStackIsEmpty [
	self assert: (completionContext leaveGroup ) equals: false 
]

{ #category : 'testing' }
CoCompletionContextTest >> testLeaveGroupWhenGroupStackIsNotEmpty [

	| group |
	group := CoEntry new children: {
			         CoGlobalEntry new.
			         CoSelectorEntry new }.

	completionContext openGroup: group.

	self assert: completionContext leaveGroup equals: true
]

{ #category : 'testing' }
CoCompletionContextTest >> testTitleWhenGroupStackIsEmpty [
	self assert: (completionContext title) equals: ''
		
]

{ #category : 'testing' }
CoCompletionContextTest >> testTitleWhenGroupStackIsNotEmpty [

	| group |
	group := CoEntry new children: {
			         (CoGlobalEntry new
				          contents: 'foo';
				          yourself).
			         (CoSelectorEntry new
				          contents: 'bar';
				          yourself) }.

	completionContext openGroup: group.

	self assert: completionContext title equals: 'Completions · ' , 'foo'
]
