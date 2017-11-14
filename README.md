# x5gon prototype 02

User interface sketch for X5gon project

## Use scenario

Same as [prototype 01](https://github.com/stefankreitmayer/x5_01_metacourse)


## Data

Similar to [prototype 01](https://github.com/stefankreitmayer/x5_01_metacourse)


## Thoughts about interface design

Iterating on [prototype 01](https://github.com/stefankreitmayer/x5_01_metacourse)

Moving away from the Google-search clone, towards a more Amazon-like design.

Goals:
1. As a learner, when I see a list of resources, in order to recognise resources easily, I want to see a picture for each resource.
2. As a learner, when I see a list of resources, in order to evaluate each resource, I want to see how each resource was rated or classified by other users.
3. As a learner, when I select a resource, in order to keep browsing, I want to stay on the platform.
4. As a learner, when I select a resource, in order to keep my resources organised, I want to put the resource into one of several categories (could be called "trays" or "baskets" or "boxes"...) such as yes/no/maybe.
5. As a learner, in order to stay organised, I want to see an overview of all my baskets and their contents.
6. As a learner, in order to stay organised, I want to move a resource from one basket to another.
7. As a learner, in order to stay organised, I want to remove a resource from a basket.
8. As a learner, when I'm done with a resource, in order to stay organised and mark the resource as good, I want to put the resource in the "worked really well for me" basket.

Once people start using the platform, I suppose we might get useful data out of tracking how learners move their resources from one basket to another over the course of their learning. Presumably, we could use these data to infer recommendability (perhaps within similar learner types) and perhaps visualise them in a way that helps learners browse more efficiently (caveat: feedback loop).


## Build instructions

To build the code you need to install [Elm](https://guide.elm-lang.org/install.html).

**Mac and Linux**:

1. Run `build.sh`
2. Open `index.html` in a browser
