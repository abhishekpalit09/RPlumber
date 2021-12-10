library(plumber)

pr <- plumber::plumb("plumber.R")

pr <- pr %>%
  pr_set_api_spec(function(spec) {
    # Define request body for POST to /predict
    spec$paths$`/predict`$post$requestBody <- list(
      description = "New data to predict",
      required = TRUE,
      content = list(
        `application/json` = list(
          # Define JSON schema
          schema = list(
            title = "Car",
            required = c("cyl", "hp"),
            properties = list(
              cyl = list(type = "integer"),
              hp = list(type = "integer")
            )
          )
        )
      ))
    spec
  })
pr

pr %>% pr_run(port = 5762)