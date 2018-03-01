#' @importFrom tibble tibble tribble
NULL

#' Sea urchins biometry.
#'
#' Various measurement on *Paracentrotus lividus* sea urchins providing from
#' fishery (Brittany, France), or from a sea urchins farm in Normandy.
#'
#' @format A data frame with ... variables:
#' \describe{
#' \item{\code{origin}}{A **factor** with two levels: `"Farm"`, and `"Fishery"`.}
#' \item{\code{diameter1}}{Diameter (in mm) of the test measured at the ambitus
#'   (its widest part).}
#' \item{\code{diameter2}}{A second diameter (in mm) measured at the ambitus,
#'   perpendicular to the first one. The idea here is to calculate the average
#'   of `diameter1` and `diameter2` in order to eliminate the effect of possible
#'   slight departure from a nearly circulat ambitus.}
#' \item{\code{height}}{The height of the test (in mm), measured from month to
#' anus, thus, orthogonally to the two diameters.}
#' \item{\code{buoyant_weight}}{Weight (in g) of the sea urchin immersed in
#'   seawater.}
#' \item{\code{weight}}{Weight (in g) of the whole animal.}
#' \item{\code{solid_parts}}{Weight (in g) of the animal after draining its
#'   coelomic fluid out of the test.}
#' \item{\code{integuments}}{Weight (in g) of the sea urchin after taking out
#'   the whole content of the test (coelomic fluid, digestive tract and gonads.}
#' \item{\code{dry_integuments}}{Dry weight (in g) of the integuments.}
#' \item{\code{digestive_tract}}{Weight (in g) of the digestive tract,
#'   including its content.}
#' \item{\code{dry_digestive_tract}}{Dry weight (in g) of the digestive tract
#'   and its content.}
#' \item{\code{gonads}}{Weight (in g) of the gonads.}
#' \item{\code{dry_gonads}}{Dry weight (in g) of the gonads.}
#' \item{\code{lantern}}{Dry weight (in g) of the lantern (the jaw and teeths of
#'   the sea urchin).}
#' \item{\code{test}}{Dry weight (in g) of the calcarous part of the test. Note
#'   that the test, plus spines and lantern form the whole calcareous skeleton
#'   of the animal.}
#' \item{\code{spines}}{Dry weight (in g) of the spines.}
#' \item{\code{maturity}}{Gonads maturity index, measured on a scale of 3
#' states: state 0 means the gonad is absent or spent, state 1 means it is
#' growing but not mature, and state 2 means the gonad is mature.}
#' \item{\code{sex}}{When it is possible, the sex of the animal is determined by
#'   visual inspection of the gonads.}
#' }
#'
#' For further details on the farming of these sea urchins, see \url{https://www.researchgate.net/publication/280021206_Land-based_closed-cycle_echiniculture_of_Paracentrotus_lividus_Lamarck_Echinoidea_Echinodermata_A_long-term_experiment_at_a_pilot_scale}
#'
"urchin_bio"

#' Sea urchins growth.
#'
#' Size at age for a cohort of farmed sea urchins, *Paracentrotus lividus*.
#'
#' @format A data frame with 3 variables: \code{date}, \code{age} (in years), \code{diameter} (in mm).
#'
#' @examples
#' SciViews::R
#' chart(urchin_growth, formula = diameter ~ age) +
#'   geom_jitter(alpha = 0.2) +
#'   xlab(label(urchin_growth$age, units = TRUE)) +
#'   ylab(label(urchin_growth$diameter, units = TRUE)) +
#'   ggtitle("Growth of a cohort of sea urchins")
"urchin_growth"
