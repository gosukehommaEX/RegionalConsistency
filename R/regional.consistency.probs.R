#' Calculate Regional Consistency Probabilities
#'
#' This function calculates approximate regional consistency probabilities
#' using Methods 1 and 2 proposed by Japanese MHLW (2007).
#' The function can obtain:
#' \itemize{
#'   \item Unconditional regional consistency probabilities
#'   \item Joint regional consistency probabilities
#'   \item Conditional regional consistency probabilities
#' }
#' For technical details, please see \url{https://doi.org/10.1002/pst.2358}
#'
#' @param f.s A numeric vector representing the proportion of patients in region s(=1,...,S)
#'        among patients in the entire trial population. Values must sum to 1.
#' @param PI A numeric value specifying the threshold for Method 1 (typically set at 0.5).
#' @param alpha A numeric value representing the one-sided level of significance.
#' @param power A numeric value representing the target power.
#' @param seed A random number seed.
#'
#' @return A list containing the following components:
#' \describe{
#'   \item{f.s}{The input proportion of patients in each region}
#'   \item{PI}{The input threshold value for Method 1}
#'   \item{alpha}{The input one-sided significance level}
#'   \item{power}{The input target power}
#'   \item{seed}{The input seed number}
#'   \item{Uncond.Method1}{Unconditional regional consistency probability for Method 1}
#'   \item{Joint.Method1}{Joint regional consistency probability for Method 1}
#'   \item{Cond.Method1}{Conditional regional consistency probability for Method 1}
#'   \item{Uncond.Method2}{Unconditional regional consistency probability for Method 2}
#'   \item{Joint.Method2}{Joint regional consistency probability for Method 2}
#'   \item{Cond.Method2}{Conditional regional consistency probability for Method 2}
#' }
#'
#' @examples
#' regional.consistency.probs(
#'   f.s = c(0.1, 0.45, 0.45),
#'   PI = 0.5,
#'   alpha = 0.025,
#'   power = 0.8,
#'   seed = 123
#' )
#'
#' @importFrom mvtnorm pmvnorm
#' @importFrom stats pnorm
#' @importFrom stats qnorm
#' @export
regional.consistency.probs <- function(f.s, PI, alpha, power, seed) {
  # Check whether sum of f.s is 1
  if(sum(f.s) != 1) stop('sum of f.s should be 1')

  ## Method 1
  Z.M1 = '/'(
    (1 - PI) * (qnorm(power) + qnorm(1 - alpha)),
    sqrt(1 / f.s[1] + PI * (PI - 2))
  )
  # Unconditional regional consistency probability
  Uncond.Method1 = pnorm(Z.M1)
  # Joint regional consistency probability
  Joint.Method1 = mvtnorm::pmvnorm(
    upper = c(qnorm(power), Z.M1),
    corr = '+'(
      t(apply(diag((1 - PI) / sqrt(1 / f.s[1] + PI * (PI - 2)), 2), 1, rev)),
      diag(1, 2)
    ),
    seed = seed
  )[1]
  # Conditional regional consistency probability
  Cond.Method1 = Joint.Method1 / (power)

  ## Method 2
  Z.M2 = sqrt(f.s) *(qnorm(power) + qnorm(1 - alpha))
  # Unconditional regional consistency probability
  Uncond.Method2 = prod(pnorm(Z.M2))
  # Joint regional consistency probability
  Joint.Method2 = mvtnorm::pmvnorm(
    upper = c(qnorm(power), Z.M2),
    corr = sqrt(c(1, f.s) %o% c(1, f.s) - c(0, f.s) %o% c(0, f.s) + diag(c(0, f.s / f.s))),
    seed = seed
  )[1]
  # Conditional regional consistency probability
  Cond.Method2 = Joint.Method2 / (power)

  ## Output
  output = list(
    f.s = f.s,
    PI = PI,
    alpha = alpha,
    power = power,
    seed = seed,
    Uncond.Method1 = Uncond.Method1,
    Joint.Method1 = Joint.Method1,
    Cond.Method1 = Cond.Method1,
    Uncond.Method2 = Uncond.Method2,
    Joint.Method2 = Joint.Method2,
    Cond.Method2 = Cond.Method2
  )

  ## Return output
  return(output)
}
