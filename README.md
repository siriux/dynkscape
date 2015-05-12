# Dynkscape
Dynkscape is a javascript library as well as a set of procedures and base svg files that allows to create dynamic svg files using Inkscape.

It's primary goal was to integrate vectorial graphics with long text descriptions in a way that it's easy to create and edit both text and graphics, while being easy to visualize and read. In this sense, it allows you to write long texts in Inkscape using Markdown inside a small rectangle. When you open this file on the browser you will see the rendered text, and it's possible to scroll on it if needed.

The next feature was to integrate a navigation system that allows you to zoom/pan/rotate on the document. The main motivation was to be able to add new things to the document without changing it's overall structure, by just making smaller things, and at the same time creating structure using size. This is similar to what Prezi does for presentations, and there is already a plugin for Inkscape that implements it (JessInk) but it was really restrictive for me.

The next step was to generalize this navigation system allowing nested navigations and allowing to include a set of slides for each navigation level.

Finally, I wanted to be able to integrate some animations on each slide that complements the texts and the graphics. For that, I've developed an animation system and a language that it's included in the Inkscape object description that allows to move/transform things around in a very simple way (all the nightmare of nested svg coodinate systems is hiden) all inside Inkscape without having to write any JS.

This was extended to allow more interaction allowing to control animations from events (clicks on objects, clicks on links in text, ...) as well as making animations more powerfull by allowing them to control text scrolls (go to Anchor), navigations and slides and other animamation. This is really powerfull and allows to implement interactive prototypes as well as full simple web sites without writing a single line of JS, all inside Inkscape.

Also, this system can be easily extended to add more functionality to the animations allowing to create even more powerfull dynamic documents.

On the other hand, the system allows to develop packages of reusable components than can be included in a project to copy and paste. This system is designed to make use of clones as much as possible in order to be able to modify/replace the original components and automatically updating every use of the component, while at the same time retaining editing capabilities on text. A base package as well as good practices to update packages and how to avoid breaking components will be provided in the future.

Most of the things described are already implemented and working, but it's still in an early stage. I hope to stat using it myself really soon to manage the desing of a project and to polish it with this experience. Also, no license is formally included yet, but it will be something along the lines of MIT/BSD/Apache.  
