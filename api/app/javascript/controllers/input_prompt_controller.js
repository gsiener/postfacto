import { Controller } from "@hotwired/stimulus"

// Handles input focus/blur to show/hide prompt and change styling
export default class extends Controller {
  static targets = ["prompt", "input"]
  static values = { inputBg: { type: String, default: '#e0f2f1' } }

  focus() {
    // Hide the prompt box
    if (this.hasPromptTarget) {
      this.promptTarget.style.display = 'none'
    }
    // Make input white and larger
    if (this.hasInputTarget) {
      this.inputTarget.style.backgroundColor = 'white'
      this.inputTarget.style.minHeight = '80px'
    }
  }

  blur() {
    // Only restore if input is empty
    if (this.hasInputTarget && !this.inputTarget.value.trim()) {
      // Show the prompt box
      if (this.hasPromptTarget) {
        this.promptTarget.style.display = 'block'
      }
      // Restore tinted background and smaller size
      this.inputTarget.style.minHeight = '44px'
      // Use the input background color from data attribute
      this.inputTarget.style.backgroundColor = this.inputBgValue
    }
  }
}
