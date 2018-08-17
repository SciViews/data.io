#' Temperature and atmospheric CO2 at Mauna Loa, Hawai
#'
#' Monthly averages of temperatures and CO2 concentrations, maximal and minimal
#' monthly temperatures at Mauna Loa slope observatory from 1955 to 2018.
#'
#' Atmospheric CO2 concentration is mole fraction in dry air, micromol/mol,
#' abbreviated as ppm. Temperatures are in degree celcius.
#'
#' @examples
#' class(mauna_loa)
#' head(mauna_loa)
#' plot(mauna_loa)
#'
#' # Using read(), the dataset becomes an annotated dataframe
#' (ml_en <- read("mauna_loa", package = "data.io"))
#' class(ml_en)
#'
#' # Indicating lang = "EN_US" (all uppercase!) also converts temperatures
#' # into degrees Farenheit
#' (ml_en_us <- read("mauna_loa", package = "data.io", lang = "EN_US"))
#' # Each variable is also labelled:
#' ml_en$avg_co2
#'
#' # The same in French:
#'  (ml_fr <- read("mauna_loa", package = "data.io", lang = "fr"))
#'   ml_fr$avg_co2
"mauna_loa"


#' Sea urchins biometry
#'
#' Various measurement on *Paracentrotus lividus* sea urchins providing from
#' fishery (Brittany, France), or from a sea urchins farm in Normandy.
#'
#' @format A data frame with 19 variables:
#' \describe{
#' \item{\code{origin}}{A **factor** with two levels: `"Culture"`, and
#'    `"Fishery"`.}
#' \item{\code{diameter1}}{Diameter (in mm) of the test measured at the ambitus
#'   (its widest part).}
#' \item{\code{diameter2}}{A second diameter (in mm) measured at the ambitus,
#'   perpendicular to the first one. The idea here is to calculate the average
#'   of `diameter1` and `diameter2` in order to eliminate the effect of possible
#'   slight departure from a nearly circular ambitus.}
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
#'  \item{\code{skeleton}}{Weight of the skeleton (g), calculated as the sum of
#'  lantern + test + spines.}
#' \item{\code{lantern}}{Dry weight (in g) of the lantern (the jaw and teeths of
#'   the sea urchin).}
#' \item{\code{test}}{Dry weight (in g) of the calcareous part of the test.}
#' \item{\code{spines}}{Dry weight (in g) of calcareous parts of the spines.}
#' \item{\code{maturity}}{Gonads maturity index (integer), measured on a scale
#'  of 3 states: state 0 means the gonad is absent or spent, state 1 means it is
#'  growing but not mature, and state 2 means the gonad is mature. This should
#'  be treated as a circular variable, since the freproductive cycle is 0 -> 1
#'  -> 2 -> 0 (spawning).}
#' \item{\code{sex}}{When it is possible, the sex of the animal is determined by
#'   visual inspection of the gonads (**factor** with levels `"F"` and `"M"`).}
#' }
#'
#' A stratified sample was performed to make sure all size classes (from 5 to 5
#' mm in test diameter) from each sub-population are equally represented in the
#' dataset. Hence, the size or weight-classes distributions among each
#' population **cannot** be studied with this dataset. However, those data are
#' more suitable to explore allometric relationships between body measurements
#' and/or body parts of the sea urchins over the whole size range.
#'
#' For further details on the farming of these sea urchins, see
#' [here](https://www.researchgate.net/publication/280021206_Land-based_closed-cycle_echiniculture_of_Paracentrotus_lividus_Lamarck_Echinoidea_Echinodermata_A_long-term_experiment_at_a_pilot_scale).
#'
"urchin_bio"

#' Sea urchins growth
#'
#' Size at age for a cohort of farmed sea urchins, *Paracentrotus lividus*.
#'
#' The same cohort of farmed sea urchins being measured at various time
#' intervals, the observations are not completelly independent from each other:
#' the same individuals aree repeatedly measured here. As the sea urchins are
#' not individually tagged, it is not possible to track them from one
#' measurement to the other. However, the whole dataset is representative of the
#' growth, and spreading of growth in a single cohort. Also, mortality could be
#' derived from the number of measurements made at each time period, since
#' **all** the individuals still alive are measured (no sub-sampling).
#'
#' @examples
#' library(ggplot2)
#' ggplot(urchin_growth, aes(age, diameter)) +
#'   geom_jitter(alpha = 0.2) +
#'   xlab(label(urchin_growth$age, units = TRUE)) +
#'   ylab(label(urchin_growth$diameter, units = TRUE)) +
#'   ggtitle("Growth of a cohort of sea urchins")
"urchin_growth"

#' Zooplankton image analysis
#'
#' Various features measured by image analysis with the package `zooimage` and
#' `ImageJ` on samples of zooplankton originating from Tulear, Madagascar. The
#' taxonomic classification is also provided in the `class` variable.
#'
#' @source Grosjean, Ph & K. Denis (2004). Supervised classification of images,
#' applied to plankton samples using R and ZooImage. Chap.12 of Data Mining
#' Applications with R. Zhao, Y. & Y. Cen (eds). Elevier. Pp 331-365.
#' https://doi.org/10.1016/C2012-0-00333-X.
#'
#' @format A data frame with 19 variables:
#' \describe{
#' \item{\code{ecd}}{The "equivalent circular diameter", the diameter of a
#'   circle with the same area as the particle (in mm).}
#' \item{\code{area}}{The area of the particle on the image (in mm^2).}
#' \item{\code{perimeter}}{The perimeter of the particle (in mm).}
#' \item{\code{feret}}{The Feret diameter, that is, the largest measured
#'   diameter of the particle on the image (mm).}
#' \item{\code{major}}{The major axis of the ellipsoid matching the particle
#'   (mm).}
#' \item{\code{minor}}{The minor axis of the same ellipsoid (mm).}
#' \item{\code{mean}}{The mean value of the gray levels calibrated in optical
#'   density (OD), thus, unitless.}
#' \item{\code{mode}}{The most frequent gray level in that particle in OD.}
#' \item{\code{min}}{The most transparent part in OD.}
#' \item{\code{max}}{The most opaque part in OD.}
#' \item{\code{std_dev}}{The stadard deviation of the OD distribution inside
#'   the particle.}
#' \item{\code{range}}{Transparency range as `max` - `min`.}
#' \item{\code{size}}{The mean diameter of the particle, as the average of
#'   `minor` and `major` (mm).}
#'  \item{\code{aspect}}{Aspect ratio of the particle as `minor`/`major`.}
#' \item{\code{elongation}}{The `area` divided by the area of a circle of the
#'   same `perimeter` of the particle.}
#' \item{\code{compactness}}{sqrt((4/pi) * `area`) / `major`.}
#' \item{\code{transparency}}{1 - (`ecd` - `size`).}
#' \item{\code{circularity}}{4pi(`area` / `perimeter`^2).}
#' \item{\code{density}}{Density integrate by the surface coevered by each gray
#'   level, i.e. O.D., inside the particle.}
#' \item{\code{class}}{The classification of this particle. 17 classes are made.
#'   Note that `Copepods` are `Calanoid` + `Cyclopoid` + `Harpactivoid` +
#'   `Poecilostomatoid` and they represent the most abundant zooplankton at sea.
#'   }
#' }
#'
#' This is a typical training set used to train a plankton classifier with
#' machine learning algorithms. Organisms originate from various samples
#' (different seasons, depth, etc. to take the variability into account).
#' However, the abundance of the different classes do **not** match abundance
#' found in each sample, i.e., rare classes are over-represented in this
#' training set. Only zooplankton classes are present in the dataset. Full data
#' also contains classes for phytoplankton, marine sno, etc. Take care that
#' several variables are correlated!
#'
#' @examples
#' table(zooplankton$class)
#' library(ggplot2)
#' ggplot(zooplankton, aes(circularity, transparency, color = class)) +
#'   geom_point()
"zooplankton"

# datasets::airquality -> air_quality (Month + Day -> Date), ... or more actual
# data?
# datasets::attitude -> survey with 1 var/7 linearly correlated with response
# datasets::ChickWeight (4 diets, but indicated 1 -> 4) vs datasets::chickwts
# (six diets, correctly identified, but only last weight given).
# datasets::CO2 is an example of adjusting SSasymp()
# datasets:esoph for a glm()
# datasets:HairEyeColor or MASS:caith (but it is a table -> how to convert?)
# datasets:Indometh for fitting SSbiexp()
# datasets:InsectSprays -> insect_sprays
# datasets:Loblolly -> growth of 14 seeds of pine. Adjust with SSasymp(), but
# only 6 measurements per seed
# datasets:Nile is a nice time series
# MASS::wtloss, MASS:waders, MASS:snails, MASS:Pima.xx, MASS:Sitka(89), MASS:OME
# MASS:biopsy
# babynames
# anscombe is OK, but also need artificial data for dynamite plot
# Add datasets:mtcars, but need to convert variables heavily! But see mpg


# Summary of datasets available  -----------------------------------------------

#' Labelised versions of various datasets provided by 'data.io' or other packages
#'
#' Use `name <- read("data", package = "pkg", lang = "xx")` to read these
#' datasets together with the metadata (labels, units, comments, ...).
#'
#' From `data`:
#' \describe{
#'   \item{\code{\link{mauna_loa}}}{Temperature and atmospheric CO2 at Mauna
#'   Loa, Hawai. 5 vars x 768 obs. Time series of monthly averages from 1955 to
#'   2018. }
#'   \item{\code{\link{urchin_bio}}}{Sea urchins biometry. 19 vars x 421 obs.
#'   Morphometric variables measured on two populations of sea urchins, incl.
#'   one circular variable (`maturity`). }
#'   \item{\code{\link{urchin_growth}}}{Sea urchins growth. 3 vars x 7024 obs.
#'   Size at age for a cohort of sea urchins followed over more than 10 years. }
#'   \item{\code{\link{zooplankton}}}{Zooplankton image analysis. 20 vars x
#'   1262 obs. A training set with 19 measurements made on images of zooplankton
#'   and their respective class as attributed by taxonomists. }
#' }
#'
#' From `datasets`:
#' \describe{
#'   \item{\code{\link{anscombe}}}{Anscombe's quartet of ‘identical’ simple
#'   linear Regressions. 8 vars x 11 obs. Artificial data. }
#'   \item{\code{\link{iris}}}{Edgar Anderson's iris data. 5 vars x 150 obs.
#'   Morphometry of the flowers of three iris species (50 for each species). }
#'   \item{\code{\link{lynx}}}{Annual canadian lynx trappings 1821–1934. 2 vars
#'   x 114 obs. Long (> 1 century) time series. }
#'   \item{\code{\link{trees}}}{Black cherry trees measurements. 3 vars x 31
#'   obs. Measurement of tree timber of various sizes. }
#' }
#'
#' From `ggplot2`:
#' \describe{
#'   \item{\code{\link{diamonds}}}{Prices of 50,000 round cut diamonds. 10 vars
#'   x 53940 obs. Price and other attributes of 10,000's of diamonds. }
#'   \item{\code{\link{mpg}}}{Fuel economy data from 1999 and 2008 for popular
#'   cars. 11 vars x 234 obs. Data are for most popular U.S. market cars only. }
#' }
#'
#' From `MASS`:
#' \describe{
#'   \item{\code{\link{crabs}}}{Morphological measurements on Leptograpsus
#'   crabs. 8 vars x 200 obs. Morphological measurements of *Leptograpsus
#'   variegatus* crabs, either blue or orange, males and females. }
#'   \item{\code{\link{geyser}}}{Old Faithful geyser data. 2 vars x 299 obs.
#'   Duration and waiting time for eruptions from August 1 to August 15, 1985. }
#' }
#'
#' From `nycflights13`:
#' \describe{
#'   \item{\code{\link{airlines}}}{Airlines by their carrier codes. 2 vars x 16
#'   obs. }
#'   \item{\code{\link{airports}}}{Various metadata about New York city
#'   airports. 8 vars x 1458 obs. }
#'   \item{\code{\link{flights}}}{On-time data for all flights that departed NYC
#'   (i.e., JFK, LGA or EWR) in 2013. 19 vars x 336776 obs. }
#'   \item{\code{\link{planes}}}{Planes metadata. 9 vars x 3322 obs. }
#'   \item{\code{\link{weather}}}{Hourly meteorological data for JFK, LGA and
#'   EWR. 15 vars x 26130 obs. }
#' }
#' @name Datasets
NULL
