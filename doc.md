# Animation #

## Entries ##

A single entry or a set of entries that define a transition in the timeline.
Some information can be described in many ways, with precedence rules.

Note: If there is a single value, the array is not needed

### General

```

target: objectID        # The objectID is like in css: "#someId"
start: time             # Global start of the action in ms
offset: time            # Offset over current time. Alternative to start.
duration: time          # Duration of the action in ms
easing: functionName    # easing function

```

### Properties

Target, duration and easing are optional

```

translate: [target, x, y, duration, easing]             # x, y relative.
scale: [target, [sX, sY], duration, easing, center]     # sX, sY relative.
                                                        # A single number can be given for [sX, sY].
                                                        # TODO Define center. Corners?
rotate: [target, r, duration, easing, center]           # r relative.
                                                        # TODO Define center. Corners?

transform: [target, [x, y], [sX,sY], r, duration, easing]   # All optional
                                                            # Less precedence than translate, scale, rotate

path: [target, pathID, duration, easing]  # Everything relative.
                                          # The path, can contain scale and rotate information.
                                          # Less precedence than translate, scale, rotate

opacity: [target, opacity, duration, easing] # Absolute. Duration and easing are optional.

text: [target, text, duration, effect]  # Set the text. Effect: typewriter, ...

```

### Effects

```

attention: [target, type, duration]   # All optional. Type: Bounce, shake, scale...

hide/show: [target, type, duration]   # All optional. Type: Fade, scale, slide ...

click: [target, pathID, duration]     # Move along path and scale effect

```

### Context

There are two types of context, the time context, that provides a default value for start.
And the target context, that provides a default value for the target.

#### Time

In a timeline, things can happen in sequence or in parallel.

Things in sequence, are preceded by "-", this is called a line. Otherwise is in parallel.
At an indentation level, you cannot mix sequence and parallel.

The things that happen in parallel at one indentation level are restricted to different entries.
If you need to use the same entry multiple times, group them by target.

When something is in sequence, the default time is advanced after each line.
The time is advanced depending on the line. If it's a single entry, is the duration.
If it's something in parallel (multiple entries, or something else), the longest duration is taken.



```
timeline: # Base of animation, sets time to 0
  - entry    # Time advances entry's duration
  - entry

  - 2000     # Just advances time 2000ms

  - entry

  - entry    Multiple entries in paralel, same default time for all
    entry
    entry
```

#### Target

A target context just defines the default target for everything under it.
The contents can be parallel or sequential, but they cannot be mixed, as before.

Here is one example of each

```
"#someID":          # Everything under it has "#someID" as it's default target
  entry
  entry

```

```
"#someID":          # Everything under it has "#someID" as it's default target
  - entry
  - entry

```

Also, targets can appear in parallel or sequential contexts.

```
timeline:
  "#A":
    ...
  "#B":
    ...
```

```
timeline:
  - "#A":
    ...
  - "#B":
    ...
```

### Other

```

label: [name, start] # Start is optional

```

## Examples ##

Simple transform: First move #A during 1s, then scale #B during 2s easing out.

```
timeline:
  - translate: ["#A", 10, 20, 1000]
  - scale: ["#B", 2, 1000]
```

Multiple parallel transforms on a target #A.
Two ways of expressing the same.

```
timeline:
  "#A":
    translate: [10, 20, 1000, "bounceOut"]
    scale: [2, 1000, "bounceOut"]

timeline:
  target: "#A"
  duration: 1000
  easing: "bounceOut"
  translate: [10, 20]
  scale: 2
```

Multiple parallel transforms on #A, then on #B

```
timeline:
  - "#A":
    translate: [10, 20, 1000]
    scale: [2, 1000]
  - "#B":
    translate: [10, 20, 1000]
    scale: [2, 1000]
```

Multiple sequence of transforms on #A, then on #B

```
timeline:
  - "#A":
    - translate: [10, 20, 1000]
    - scale: [2, 1000]
  - "#B":
    - translate: [10, 20, 1000]
    - scale: [2, 1000]
```

The same, but parallel on #A and #B

```
timeline:
  "#A":
    - translate: [10, 20, 1000]
    - scale: [2, 1000]
  "#B":
    - translate: [10, 20, 1000]
    - scale: [2, 1000]
```

Like before, but transforms on each element are in parallel

```
timeline:
  "#A":
    translate: [10, 20, 1000]
    scale: [2, 1000]
  "#B":
    translate: [10, 20, 1000]
    scale: [2, 1000]
```

Like before, but #B starts 500ms later (also in parallel)

```
timeline:
  "#A":
    translate: [10, 20, 1000]
    scale: [2, 1000]
  "#B":
    500:
      translate: [10, 20, 1000]
      scale: [2, 1000]
```
