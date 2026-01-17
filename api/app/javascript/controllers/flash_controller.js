import { Controller } from "@hotwired/stimulus"

// Auto-dismisses flash messages after a delay
export default class extends Controller {
  static values = {
    delay: { type: Number, default: 5000 }
  }

  connect() {
    this.timeout = setTimeout(() => {
      this.dismiss()
    }, this.delayValue)
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  dismiss() {
    this.element.classList.add("transition", "opacity-0")
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
