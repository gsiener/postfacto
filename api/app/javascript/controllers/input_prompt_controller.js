import { Controller } from "@hotwired/stimulus"

// Handles input focus/blur to show/hide prompt and change styling
export default class extends Controller {
  static targets = ["prompt", "input"]

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
      // Get the original background color from inline style or use default
      const category = this.inputTarget.closest('form')?.querySelector('[name*="category"]')?.value
      let bgColor = '#e0f2f1' // teal tint
      if (category === 'meh') bgColor = '#fef9e7'
      if (category === 'sad') bgColor = '#fce4e4'
      this.inputTarget.style.backgroundColor = bgColor
    }
  }
}
