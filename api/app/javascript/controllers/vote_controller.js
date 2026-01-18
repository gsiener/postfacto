import { Controller } from "@hotwired/stimulus"

// Handles voting on retro items with animation feedback
export default class extends Controller {
  static targets = ["count", "button"]
  static values = {
    itemId: Number,
    retroId: String
  }

  vote(event) {
    // Don't prevent default - let the form submit via Turbo

    // Add animation class for visual feedback
    if (this.hasCountTarget) {
      this.countTarget.classList.add("animate-bounce")
      setTimeout(() => {
        this.countTarget.classList.remove("animate-bounce")
      }, 500)
    }

    // Form will be submitted via Turbo
  }

  // Called when Turbo Stream updates the vote count
  countTargetConnected() {
    // Re-enable button after update
    if (this.hasButtonTarget) {
      this.buttonTarget.disabled = false
    }
  }
}
