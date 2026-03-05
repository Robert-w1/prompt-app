// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// Re-initialize Bootstrap components that require explicit init after Turbo navigations
document.addEventListener("turbo:load", () => {
  // Sidebar toggle
  const toggle = document.getElementById("sidebar-toggle")
  const sidebar = document.getElementById("sidebar")

  if (toggle && sidebar) {
    toggle.addEventListener("click", () => {
      sidebar.classList.toggle("collapsed")
    })
  }

  // Avatar dropdown
  const avatarBtn = document.getElementById("avatar-toggle")
  const avatarDropdown = document.getElementById("avatar-dropdown")

  if (avatarBtn && avatarDropdown) {
    avatarBtn.addEventListener("click", (e) => {
      e.stopPropagation()
      avatarDropdown.classList.toggle("open")
    })

    document.addEventListener("click", () => {
      avatarDropdown.classList.remove("open")
    })
  }
})
