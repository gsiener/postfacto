import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { retroId: String }

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  handleKeydown(event) {
    if (this.isTyping(event)) return
    switch (event.key) {
      case "ArrowRight": this.nextItem(); break
      case "ArrowLeft": this.previousItem(); break
      case "Escape": this.unhighlight(); break
    }
  }

  isTyping(event) {
    const target = event.target
    return target.tagName === "INPUT" || target.tagName === "TEXTAREA" || target.isContentEditable
  }

  nextItem() {
    document.querySelector("[data-hotkeys-action='next']")?.click()
  }

  previousItem() {
    document.querySelector("[data-hotkeys-action='previous']")?.click()
  }

  unhighlight() {
    document.querySelector("[data-hotkeys-action='unhighlight']")?.click()
  }
}
