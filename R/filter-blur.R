

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Create an SVG blur filter
#'
#' Create a filter to apply Gaussian blur to an element.
#'
#' For more information see the MDN SVG docs for
#' \href{https://developer.mozilla.org/en-US/docs/Web/SVG/Element/feGaussianBlur}{feGaussianBlur}
#'
#'
#' @param id id to use for filter.
#' @param std_dev standard deviation of the gaussian blue. default: 3
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
#' blur_filter <- create_filter_blur(id = 'myblur')
#' doc$defs(blur_filter)
#'
#' # Create a rectangle with the animation
#' rect  <- stag$rect(
#'   x      = "10%",
#'   y      = "10%",
#'   width  = "80%",
#'   height = "80%",
#'   fill   = "lightblue",
#'   stroke = 'black',
#'   filter = blur_filter
#' )
#'
#' # Add this rectangle to the document, show the SVG text, then render it
#' doc$append(rect)
#' doc
#' doc$show()
#' }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create_filter_blur <- function(id, std_dev = 3, ...) {

  blur <- minisvg::SVGFilter$new(
    id = id,
    x = "-20%", y = "-20%", width="140%", height="150%",
    stag$feGaussianBlur(
      in_          = 'SourceGraphic',
      stdDeviation = std_dev
    )
  )

  blur
}



if (FALSE) {
  pat <- create_filter_blur(id = 'hello')
  pat
  pat$show(width=400, height = 200)
  pat$save_full_svg("working/one.svg", width=400, height = 100)
}
