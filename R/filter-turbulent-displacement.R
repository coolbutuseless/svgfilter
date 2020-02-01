

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create an animated SVG turbulent displacement filter
#'
#' Use turblence to displace an element.
#'
#'
#' The turbulent displacement effect is a combination of 2 primitive SVG filters:
#'
#' \enumerate{
#' \item{Create turbulence}
#' \item{Use the turblence as a displacment map for the object}
#' }
#'
#'
#' For more information see the MDN SVG docs for
#' \href{https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feGaussianBlur}{feTurbulence}
#' and \href{https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feDisplacementMap}{feDisplacementMap}
#'
#' @param id id to use for filter.
#' @param scale scale of the displacement
#' @param octaves corresponds to \code{feTurbulence - numOctaves} parameter. default: 4
#' @param fps frames per second. default: 8
#' @param freqx,freqy base frequency in x and y directions. default: freqx = 0.05, freqy = freqx
#' @param frames number of frames. default: 20
#' @param ... other arguments ignored
#'
#' @return minisvg::SVGElement object representing a filter
#'
#' @import minisvg
#' @export
#'
#'
#' @examples
#' \dontrun{
#' # Create an SVG document
#' library(minisvg)
#' doc   <- minisvg::svg_doc()
#'
#' # Create the filter and add to the SVG definitions
#' turb_filter <- create_filter_turbulent_displacement(id = 'turb')
#' doc$defs(turb_filter)
#'
#' # Create a rectangle with the animation
#' rect  <- stag$rect(
#'   x      = "10%",
#'   y      = "10%",
#'   width  = "80%",
#'   height = "80%",
#'   fill   = "lightblue",
#'   stroke = 'black',
#'   filter = turb_filter
#' )
#'
#' # Add this rectangle to the document, show the SVG text, then render it
#' doc$append(rect)
#' doc
#' doc$show()
#' }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create_filter_turbulent_displacement <- function(id,
                                                 scale   = 50,
                                                 octaves = 4,
                                                 fps     = 8,
                                                 freqx   = 0.05,
                                                 freqy   = freqx,
                                                 frames  = 20,
                                                 ...) {


  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Red to gold vertical linear gradient
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (fps == 0) {
    keyTimes    <- NULL
    duration    <- NULL
    seed_values <- 1
  } else {

    keyTimes <- seq(0, 1, length.out = frames+1) # anim must go from 0 to 1
    duration <- frames/fps
    if (!is.finite(duration)) {
      stop("create_turbulent_displacment_filter(): not a finite duration given frames=", frames, ", fps=", fps,
           call. = FALSE)
    }

    seed_values <- c(seq(frames), 1) # anim must loop back to stat
  }

  freq <- paste(unique(c(freqx, freqy)), collapse = " ")

  turbulent_displacement <- minisvg::SVGFilter$new(
    id = id,
    x = "-30%", y = "-30%", width="160%", height="160%",
    stag$feTurbulence(
      type          = "turbulence",
      baseFrequency = freq,
      numOctaves    = octaves,
      seed          = 1,
      stag$animate(
        attributeName = 'seed',
        values        = seed_values,
        dur           = duration,
        keyTimes      = keyTimes,
        repeatCount   = "indefinite",
        calcMode      = 'discrete'
      ),
      result        = "turbulence"),
    stag$feDisplacementMap(
      in_   = "SourceGraphic",
      in2   = "turbulence",
      scale = scale,
      xChannelSelector = 'R',
      yChannelSelector = 'G',
      NULL
    )
  )

  turbulent_displacement
}



if (FALSE) {
  pat <- create_filter_turbulent_displacement(id = 'hello', freqx = 0.01, freqy = 0.1)
  pat
  pat$show(width=400, height = 200)
  pat$save_full_svg("working/one.svg", width=400, height = 100)
}
