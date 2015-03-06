# Entities

- Animation Objects
  - Can have element, name, class, dimensions, state
  - Can act as a view for a navigation
  - Classes: TextScroll, Path, Clip, Slide, Navigation
  - Attributes
    - namespace
    - name
    - class
    - text: align, process
    - clip: clipName
    - slide: num, duration, easing
    - navigation: layer, start, showViews, lock
    - animations:
      vars: ... ; To define a base variables for all the animations
      @init ....: ... ; Special, on init animate itself or others
      @click ...: ... ; Special, on click animate itself or others
      @slide ...: ... ; Special, slide animation
      ...
      @animationName ...: ...; Other animations
      ...

# Animations

Animations are composed of three types steps, that can be nested. Each step has
a left side, that defines the step type and context, and a right side that defines
it's parameters and/or context, or the child steps. Both sides are separated by a :

On the left size first we have an optional step type. The main step is defined
by @animationName, and defines a new animation with it's name. Then, we can have
sequential, or parallel steps, defined by - and / respectively. In some situations
the type definition can be omitted, and is assumed parallel.

All the child steps of the same step must be of the same type, sequential or parallel.

After the type, separated by a space, we can optionally have a action name.
If an action name is provided, the right side will contain a single line with
action and/or context variables. Otherwise, the right is composed of child steps, which
are in the next line, and indented one more level than the parent.

After the optional action name, on the left side can appear multiple variables
separated by spaces. A variable is specified by the variable name or short name,
the = symbol, and a value (without any space). The context variables have an order,
if they are specified in the right order, the name and = symbol can be omitted, but once a name
is provided, it must be provided for all the following variables.

The ordered context variable names (with short name in parenthesis) are:
target(t), duration(d), easing(e), offset(o), center(c), namespace(n), label(l).

Any variable can be used by the actions. They take the closest defined value for
the variable, if provided, or a default value. Defaults can be different for each action.

For action steps, on the right side appear a set of variables with the same format
as described before. This variables can be action specific or context. As before,
they have a name and optionally a short name. The action variables have an order,
and are before the context ones.

It's importante to note that for indentation, the number of spaces counts. But for the
other spaces, multiple spaces are treated as a single one.

The variables can appear in the place of a value. They start with $, followed by
the variable name. For example: $myVar. TODO Expressions can be placed inside ${ exp }

As a style guide:

Indentation should be one space per level, and variables can be optionally aligned using spaces.

All context variables are used with the short name, except the target that is used
without any name (because it's easy to identify visually).

Also, on action steps, if needed, the target is specified on the left side, and
the other context variables on the right side, after the action variables.

Action specific variable names, should not be used as general variables. In this case
is better to define a new variable name, and provide it explicitly on each action.

## Examples

Animation with multiple sequential steps. Scale, then rotate.

```
@slide #objectName:
 - scale:  2   d=1.5 e=inout
 - rotate: -45 d=2   e=linear
```

Parallel animation on multiple targets, sequential on each target.

```
@myanim e=springout:
 / #objectA:
  - scale:  2  d=1.5
  - rotate: 30 d=3
 / #objectB o=300:
  - scale:  2  d=7 e=linear
  - rotate: 30 d=2.3
```
