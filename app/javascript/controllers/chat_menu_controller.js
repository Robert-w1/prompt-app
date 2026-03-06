import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // Close any open dropdown when clicking anywhere outside
    this.closeAll = this.closeAll.bind(this)
    document.addEventListener("click", this.closeAll)
  }

  disconnect() {
    // Clean up listener when controller is removed from DOM
    document.removeEventListener("click", this.closeAll)
  }

  toggle(e) {
    // Prevent click from bubbling to the document close listener
    e.stopPropagation()

    // Find the dropdown inside this chat-menu-wrapper
    const dropdown = this.element.querySelector(".chat-menu-dropdown")

    // Close all other open dropdowns first
    document.querySelectorAll(".chat-menu-dropdown.open").forEach(d => {
      if (d !== dropdown) d.classList.remove("open")
    })

    // Toggle this dropdown open or closed
    dropdown.classList.toggle("open")
  }

  closeAll() {
    // Close all open dropdowns
    document.querySelectorAll(".chat-menu-dropdown.open").forEach(d => d.classList.remove("open"))
  }
}
