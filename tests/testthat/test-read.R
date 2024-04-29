test_that("read() R package datasets", {
  expect_s3_class(read("urchin_bio", package = "data.io"), "data.frame")
})

