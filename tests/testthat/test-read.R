context("read")

describe("read() R package datasets", {

  it("reads package datasets when package= argument is provided", {
    expect_is(read("urchin_bio", package = "data"), "data_frame")
  })
})
