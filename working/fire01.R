

library(minisvg)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Define filter with turbulence driving the displacmenet
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
my_filter <- stag$filter(
  id = "displacementFilter",
  x = "-30%", y = "-30%", width="160%", height="160%",
  stag$feTurbulence(
    type          = "turbulence",
    baseFrequency = 0.05,
    numOctaves    = 5,
    seed          = 2,
    stag$animate(attributeName = 'seed', values=1:20, dur="2s", keyTimes = seq(0, 1, length.out = 20), repeatCount = "indefinite"),
    result        = "turbulence"),
  stag$feDisplacementMap(
    in_   = "SourceGraphic",
    in2   = "turbulence",
    scale = 50,
    yChannelSelector = 'G',
    # stag$animate(attributeName = 'scale', values="0;200;0", dur="10s", repeatCount = "indefinite"),
    NULL
  )
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Red to gold vertical linear gradient
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fire_grad <- stag$linearGradient(
  id = "myGradient",
  gradientTransform = "rotate(90)",
  stag$stop(offset =  "5%", stop_color = "gold"),
  stag$stop(offset = "95%", stop_color = "red" )
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Apply this displacement filter to a small rect with a red gradient fill
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
doc <- svg_doc(
  width = 400, height = 400,
  my_filter,
  stag$defs(
    my_filter,
    fire_grad
  ),
  stag$rect(
    x      = 100,
    y      = 100,
    width  = 200,
    height = 20,
    fill   = fire_grad,
    filter = my_filter,
    NULL
  )
)

doc$show()


