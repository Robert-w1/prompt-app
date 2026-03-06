import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Declare the HTML elements this controller needs to reference
  // Stimulus will automatically find elements with data-search-target="input" etc.
  static targets = ["input", "results", "dropdown"]

  connect() {
    // Called when the controller is attached to the DOM
    // Initialize the debounce timer as null so we can use it later
    this.debounceTimer = null
  }

  toggle(e) {
    // Stop the click from bubbling up to the window listener (which would immediately close it)
    e.stopPropagation()

    // Add or remove the "open" class on the dropdown to show/hide it
    this.dropdownTarget.classList.toggle("open")

    // If we just opened it, move focus to the input so the user can type straight away
    if (this.dropdownTarget.classList.contains("open")) {
      this.inputTarget.focus()
    }
  }

  close() {
    // Called when the user clicks anywhere on the window outside the dropdown
    this.dropdownTarget.classList.remove("open")
  }

  stopClose(e) {
    // Stop clicks inside the dropdown from bubbling up to the window close listener
    e.stopPropagation()
  }

  search() {
    // Clear any previous debounce timer so we don't fire multiple requests
    clearTimeout(this.debounceTimer)

    // Get the current value of the search input
    const query = this.inputTarget.value.trim()

    // If the query is too short, reset the results and bail out
    if (query.length < 2) {
      this.resultsTarget.innerHTML = '<p class="search-hint">Type at least 2 characters...</p>'
      this.previewTarget.classList.remove("open")
      return
    }

    // Wait 300ms after the user stops typing before firing the request
    // This avoids sending a request on every single keystroke
    this.debounceTimer = setTimeout(() => {
      fetch(`/search?q=${encodeURIComponent(query)}`, {
        // Tell Rails we want JSON back, not HTML
        headers: { "Accept": "application/json" }
      })
      .then(res => res.json()) // Parse the response as JSON
      .then(data => this.renderResults(data)) // Pass the data to renderResults
    }, 300)
  }

  renderResults(data) {
      console.log(data) // ADD THIS — shows the full JSON response in browser console
    // Combine all result types into one flat array
    const all = [
      ...(data.chats || []),
      ...(data.messages || []),
      ...(data.projects || [])
    ]

    // If nothing came back, show a "no results" message
    if (all.length === 0) {
      this.resultsTarget.innerHTML = '<p class="search-hint">No results found.</p>'
      return
    }

    // Human-readable labels for each result type shown above the result title
    const labels = { chat: "Chat", message: "Message", project: "Project" }

    // Build the HTML for each result and inject it into the results container
    this.resultsTarget.innerHTML = all.map(item => `
      <div class="search-result-item"
           data-url="${item.url}"
           data-action="click->search#selectResult">
        <span class="search-result-type">${labels[item.type]}</span>
        <!-- show name if available, otherwise content, otherwise title -->
        <p class="search-result-title">${item.name || item.title || item.content}</p>
      </div>
    `).join("") // join("") turns the array of strings into one big HTML string
  }

  selectResult(e) {
  // Navigate directly to the result when clicked
  window.location.href = e.currentTarget.dataset.url
  }
}
