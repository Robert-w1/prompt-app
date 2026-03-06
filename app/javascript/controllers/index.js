// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Import our new search Stimulus controller
import SearchController from "./search_controller"

// Register it under the name "search" — this matches data-controller="search" in the HTML
application.register("search", SearchController)
