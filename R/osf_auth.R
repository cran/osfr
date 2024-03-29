#' Authenticate osfr with a personal access token
#'
#' Authorize osfr to interact with your OSF data and OSF account by passing a
#' personal access token (PAT) to `osf_auth()`. If no `token` is provided,
#' `osf_auth()` will attempt to obtain a PAT from the `OSF_PAT` environment
#' variable. However, since osfr checks for the presence of `OSF_PAT` on
#' start-up, this is only necessary if the variable was created or redefined in
#' the middle of a session. See below for additional details and instructions
#' for generating and utilizing your PAT.
#'
#' Out of the box osfr can only access publicly available projects, components,
#' and files on OSF. In order for osfr to view and manage your private resources
#' you must provide a Personal Access Token (PAT). The following instructions
#' will walk you through the process of generating a PAT and using it to
#' authenticate osfr.
#'
#' @param token OSF personal access token.
#' @examples
#' \dontrun{
#' # manually authenticate with a PAT
#' osf_auth("bdEEFMCuBtaBoSK11YzyjOdjUjKtWIj2FWxHl6kTBRax7uaeyBghALumTO1kT8RA")
#' }
#'
#' @return Invisibly returns your OSF PAT along with a message indicating it was
#'   registered.
#'
#' @section Creating an OSF personal access token:
#'
#' - Navigate to <https://osf.io/settings/tokens/>
#' - Click the *New token* button and provide a descriptive name
#' - Select the scopes (i.e., permissions) you'd like to grant osfr
#' - Click the *Create* button to generate your PAT
#' - If successful, your 70 character token will be displayed along with several
#'   important warnings you should definitely read over carefully
#' - You read those warnings, right?
#' - Copy your token and keep it in a safe place
#'
#' @section Using your PAT with osfr:
#'
#' There are two possible approaches for authenticating osfr with your PAT.
#'
#' The simpler approach is to call the `osf_auth()` function at the start of
#' every new R session and manually paste in your token. Note that your PAT
#' should be treated like a password and, as such, should not be hardcoded into
#' your script.
#'
#' A better approach is to store your PAT as an environment variable called
#' `OSF_PAT`. Doing so will allow osfr to detect and utilize the token
#' automatically without any need to manually call `osf_auth()`. One way to
#' accomplish this is by creating an `.Renviron` file in your home or working
#' directory that defines the `OSF_PAT` variable. For example:
#'
#' ```
#' OSF_PAT=bdEEFMCuBtaBoSK11YzyjOdjUjKtWIj2FWxHl6kTBRax7uaeyBghALumTO1kT8RA
#' ```
#'
#' For new users we suggest adding the `.Renviron` to your home directory so it
#' is automatically applied to all your projects. To verify this was done
#' correctly, restart R and run `Sys.getenv("OSF_PAT")`, which should return
#' your PAT.
#'
#' @references
#' 1. Colin Gillespie and Robin Lovelace (2017). *Efficient R programming*.
#' O'Reilly Press. <https://csgillespie.github.io/efficientR/>.
#'
#' @export
osf_auth <- function(token = NULL) {

  if (is.null(token)) {
    env_pat <- Sys.getenv("OSF_PAT")
    if (nzchar(env_pat)) token <- env_pat
    source <- "OSF_PAT environment variable"
  } else {
    stopifnot(is.character(token))
    source <- "provided token"
  }

  if (is.null(token)) {
    warning("No PAT found. See ?osf_auth for help")
  } else {
    message("Registered PAT from the ", source)
  }

  options(osfr.pat = token)
  invisible(token)
}
