

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create an SVG drop shadow filter
#'
#' This filter adds a drop shadow to the element it is applied to.
#'
#' The drop shadow effect is a combination of 4 primitive SVG filters:
#'
#' \enumerate{
#' \item{Blur the element}
#' \item{Offset this blurred image}
#' \item{Fill the blurred image with the given colour using a flood and a composite}
#' \item{Layer the drop shadow behind the original image}
#' }
#'
#'
#' For more information see the MDN SVG docs for
#' \href{https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feGaussianBlur}{feGaussianBlur}
#'
#'
#' @param id id to use for filter.
#' @param dx,dy offset of shadow in x and y directions. default: 10
#' @param std_dev standard deviation of the gaussian for the blur. default: 3
#' @param colour default: #bbb
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
#' drop_shadow_filter <- create_filter_drop_shadow(id = 'dshadow')
#' doc$defs(drop_shadow_filter)
#'
#' # Create a rectangle with the animation
#' rect  <- stag$rect(
#'   x      = "10%",
#'   y      = "10%",
#'   width  = "80%",
#'   height = "80%",
#'   fill   = "lightblue",
#'   stroke = 'black',
#'   filter = drop_shadow_filter
#' )
#'
#' # Add this rectangle to the document, show the SVG text, then render it
#' doc$append(rect)
#' doc
#' doc$show()
#' }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create_filter_drop_shadow <- function(id, dx = 10, dy = dx,
                                      std_dev = 3, colour = '#bbb', ...) {

  drop <- minisvg::SVGFilter$new(
    id = id,
    x = "-20%", y = "-20%", width="140%", height="150%",
    stag$feOffset(
      in_    = 'SourceAlpha',
      result = 'offset_output',
      dx     = dx,
      dy     = dy
    ),
    stag$feGaussianBlur(
      in_          = 'offset_output',
      result       = 'blur_output',
      stdDeviation = std_dev
    ),
    stag$feFlood(
      flood_color = colour,
      result      = 'flood_image'
    ),
    stag$feComposite(
      in_     = 'flood_image',
      in2     = 'blur_output',
      operator = 'in',
      result   = 'composite_output'
    ),
    stag$feBlend(
      in_  = 'SourceGraphic',
      in2  = 'composite_output',
      mode = 'normal'
    )
  )

  drop
}



if (FALSE) {
  pat <- create_filter_drop_shadow(id = 'hello', colour = 'red')
  pat
  pat$show(width=400, height = 200)
  # pat$save_full_svg("working/one.svg", width=400, height = 100)
}
