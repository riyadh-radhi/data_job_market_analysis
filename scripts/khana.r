box::use(
    jsonlite[...],
    here[...],
    dplyr[...],
    tidyr[...],
    tidytext[...],
    stringr[...],
    lubridate[...]
)

khana_json <- jsonlite::fromJSON(
    txt =
        here::here("raw_data", "khana.json"), flatten = TRUE
)
khana_df <- as.data.frame(khana_json[4])


khana_df <- khana_df |>
    dplyr::select(messages.date, messages.text) |>
    dplyr::mutate(messages.date = lubridate::as_date(messages.date)) |>
    dplyr::mutate(year = lubridate::year(messages.date)) |>
    dplyr::mutate(messages.text = sapply(messages.text, function(x) paste(unlist(x), collapse = " ")))


needed_df <- khana_df |>
    dplyr::filter(
        grepl("data", messages.text, ignore.case = TRUE)
    )

needed_df  |> dplyr::group_by(year)  |> dplyr::count(sort = TRUE)
