f.s = c(0.1, 0.45, 0.45)
PI = 1
alpha = 0.025
power = 0.8
seed = 123

results = regional.consistency.probs(f.s, PI, alpha, power, seed)

test_that('Check regional.consistency.probs results', {
  expect_identical(length(results),  as.integer(5 + 3 * 2))
  expect_identical(results$Uncond.Method1, 0.5)
  expect_identical(results$Joint.Method1,  0.5 * power)
  expect_identical(results$Cond.Method1,   results$Joint.Method1 / power)
})
