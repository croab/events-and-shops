// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }