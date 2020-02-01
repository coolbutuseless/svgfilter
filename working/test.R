

library(minisvg)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Define filter with turbulence driving the displacmenet
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
my_filter <- stag$filter(
  id = "displacementFilter",
  stag$feTurbulence(
    type          = "turbulence",
    baseFrequency = 0.05,
    numOctaves    = 2,
    result        = "turbulence"),
  stag$feDisplacementMap(
    in_   = "SourceGraphic",
    in2   = "turbulence",
    scale = 50,
    xChannelSelector = 'R',
    yChannelSelector = 'G',
    stag$animate(attributeName = 'scale', values="20;70;40;50;20", dur="3s", repeatCount = "indefinite"),
    NULL
  )
)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Apply this displacement filter to a circle
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
doc <- svg_doc(
  width = 400, height = 400,
  my_filter,
  stag$circle(cx=200, cy=200, r=80, filter = my_filter,
              stag$animateTransform(attributeName = "transform", attributeType = 'XML',
                                    type = "rotate", from = "0 200 200", to = "360 200 200 ",
                                    dur = "7s", repeatCount = "indefinite"))
)


doc$show()
