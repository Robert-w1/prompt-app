// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import * as bootstrap from "bootstrap"

// Re-initialize Bootstrap components that require explicit init after Turbo navigations
document.addEventListener("turbo:load", () => {
  const toggle = document.getElementById("sidebar-toggle")
  const sidebar = document.getElementById("sidebar")

  if (toggle && sidebar) {
    toggle.addEventListener("click", () => {
      console.log("Toggling sidebar")
      sidebar.classList.toggle("collapsed")
    })
  }
})
