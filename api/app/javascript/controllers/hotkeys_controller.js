import { Controller } from "@hotwired/stimulus"

// Handles keyboard shortcuts for retro navigation
export default class extends Controller {
  static values = {
    retroId: String
  }

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  handleKeydown(event) {
    // Don't trigger shortcuts when typing in form fields
    if (this.isTyping(event)) return

    switch (event.key) {
      case "ArrowRight":
        this.nextItem()
        break
      case "ArrowLeft":
        this.previousItem()
        break
      case "Escape":
        this.unhighlight()
        break
    }
  }

  isTyping(event) {
    const target = event.target
    return target.tagName === "INPUT" ||
           target.tagName === "TEXTAREA" ||
           target.isContentEditable
  }

  nextItem() {
    const nextButton = document.querySelector("[data-hotkeys-action='next']")
    if (nextButton) {
      nextButton.click()
    }
  }

  previousItem() {
    const prevButton = document.querySelector("[data-hotkeys-action='previous']")
    if (prevButton) {
      prevButton.click()
    }
  }

  unhighlight() {
    const unhighlightButton = document.querySelector("[data-hotkeys-action='unhighlight']")
    if (unhighlightButton) {
      unhighlightButton.click()
    }
  }
}
