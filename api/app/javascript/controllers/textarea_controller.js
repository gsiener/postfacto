import { Controller } from "@hotwired/stimulus"

// Handles textarea expansion on focus
export default class extends Controller {
  expand() {
    this.element.style.minHeight = '80px'
  }

  collapse() {
    // Only collapse if empty
    if (!this.element.value.trim()) {
      this.element.style.minHeight = '48px'
    }
  }
}
