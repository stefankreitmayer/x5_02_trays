# Metacourse prototype 01

User interface sketch for X5gon project

## Use scenario

Stefan wants to get an overview of machine learning (ML). His goal is to understand which technologies are available today, what can and cannot be done with ML, and what the strengths and weaknesses of different techniques are.

Stefan knows English and German. He has no preference for either.

Stefan has a background in software development.
He has never really used ML or AI. He isn't even sure about the difference.

There is abundance of available OERs on the topic.

Stefan wants to know where to start.
He wants to know which OER (or combination of OERs) will satisfy his learning goal most efficiently.
He would appreciate a guided introduction that clearly explains what is what.
Ideally, he would like the experience to be pleasant, motivating, inspiring, and fun.

Since he works full-time, Stefan has a preference for resources that he could use while commuting, exercising, or doing chores.

Stefan goes to metacourse.com (proposed title) and types in "machine learning introduction"

An ideal system would tell Stefan, "these are the 3 items you'll be most happy with. Use these two in parallel, and that one in the end." Much like at a pharmacy. However, until our artificial chemist is trustworthy enough, we're going to have to show a long list of options. Interfaces that assist the learner in combining options are conceivable.


## Data

Hardcoded list of OERs. Real URLs augmented with some manual annotations and some generated fake data.

URL sources:
* First 2 pages of google search results for "machine learning introduction", minus some non-OER results
* All results from videolectures.net search for "machine learning introduction" that have "machine learning" in the title
* Some additional coursera courses
* A few highly recommended resources that I thought shouldn't be missing

Metadata sources:
* Some metadata was determined based on known URL patterns.
* Various hard-to-get data, such as user ratings, was faked algorithmically as needed


## Thoughts about interface design

The interface should aim to:
1. satisfy the learner's goals
2. optimise for the learner's preferences

As a first educated guess, I started with a familiar layout, borrowing from Google search and others.

Every search result is considered a "resource". Each resource is shown by its title, url, and annotations. While title and url are straightforward, visualising the annotations is an interesting challenge. There is scope for developing a custom visual language to help learners recognise features and relations quickly and easily.

Annotations include:
* type of resource (mooc, podcast, video, text, audiobook, etc)
* screen required
* free of charge
* etc

Conceivable alternatives to the traditional list view may include:
* a view that highlights prerequisites (tree? perhaps more relevant in cases where it isn't about introductions)
* a view that supports selecting a well-balanced mix of screen, audio, physical and social resources
* a view that highlights overlaps (redundancy) in content

I could imagine a toggle/select for switching between different views.

Depending on what attributes users will want to filter for (to be tested), I wonder whether there will be a clear distinction between filters (constraints per search) and settings (constraints per user).

Should users be allowed to custom-sort their results? (unlike Google search) - If so, should we stick with the traditional 1-criterion approach or offer something more sophisticated, such as multiple criteria and weights? User testing will tell.


## Build instructions

To build the code you need to install [Elm](https://guide.elm-lang.org/install.html).

**Mac and Linux**:

1. Run `build.sh`
2. Open `index.html` in a browser
