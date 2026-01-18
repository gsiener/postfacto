import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["count", "button"]

  vote(event) {
    if (this.hasCountTarget) {
      this.countTarget.classList.add("animate-bounce")
      setTimeout(() => this.countTarget.classList.remove("animate-bounce"), 500)
    }
  }
}
